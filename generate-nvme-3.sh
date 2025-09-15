#!/usr/bin/env bash

set -e

PATH_OLD=$PATH
DATADIR=/mnt/raid-sata/data-prefetch

ROWS=10000000
STEPS=10

TS=$(date +%Y%m%d-%H%M%S)

killall -9 postgres || true
sleep 1

rm -Rf $DATADIR

PATH=/home/tomas/builds/master/bin:$PATH_OLD

pg_ctl -D $DATADIR init
pg_checksums --disable $DATADIR
pg_ctl -D $DATADIR start
createdb test
pg_ctl -D $DATADIR stop

mkdir $TS
mkdir $TS/samples

for step in 32 1 16 2 8 4; do

	fuzz=-1;

	while [[ "$fuzz" -le "$ROWS" ]]; do

		for fuzz2 in 0 2 8 32 128 512 2048; do

			for fillfactor in 20 40 60 80 100; do

				echo "$step $fuzz $fuzz2 $fillfactor" >> $TS/parameters.list

			done

		done

		if [ "$fuzz" == "-1" ]; then
			fuzz=0
		elif [ "$fuzz" == "0" ]; then
			fuzz=1
		else
			fuzz=$((fuzz*4))
		fi

	done

done

sort -R $TS/parameters.list > $TS/parameters.random

echo did qid seed fillfactor ROWS distinct relpages fuzz fuzz2 step iomethod ioworkers eic direction run iorder order b values start end time_uncached time_cached distance_uncached distance_cached buffers_read buffers_hit >> $TS/results.csv

c=0
qid=0
did=0

while IFS= read -r line; do

	IFS=', ' read -r -a strarray <<< "$line"

	step="${strarray[0]}"
	fuzz="${strarray[1]}"
	fuzz2="${strarray[2]}"
	fillfactor="${strarray[3]}"

	for direction in increase decrease; do

		coeff="1"
		if [ "$direction" == "decrease" ]; then
			coeff="-1"
		fi

		for iorder in asc desc; do

			io=""
			if [ "$iorder" == "asc" ]; then
				io="ASC"
			elif [ "$iorder" == "desc" ]; then
				io="DESC"
			fi

			echo $fillfactor $fuzz $fuzz2 $iorder

			PATH=/home/tomas/builds/master/bin:$PATH_OLD

			pg_ctl -D $DATADIR -l $TS/pg.log start

			distinct=$((ROWS/step))

			seed=$(psql -t -A test -c "select random()")

			psql test -c "drop table if exists t"
			psql test -c "create unlogged table t (a bigint, b text) with (fillfactor = $fillfactor)"

			if [ "$fuzz" == "-1" ]; then
				insert="insert into t select $coeff * a, b from (select r, a, b, generate_series(0,$step-1) AS p from (select row_number() over () as r, a, b from (select i AS a, md5(i::text) AS b from generate_series(1, $distinct) s(i) ORDER BY random()) foo) bar) baz ORDER BY ((r * $step + p) + $fuzz2 * (random() - 0.5))"
			else
				insert="insert into t select $coeff * a, b from (select r, a, b, generate_series(0,$step-1) AS p from (select row_number() over () AS r, a, b from (select i AS a, md5(i::text) AS b from generate_series(1, $distinct) s(i) ORDER BY (i + $fuzz * (random() - 0.5))) foo) bar) baz ORDER BY ((r * $step + p) + $fuzz2 * (random() - 0.5))"
			fi

			did=$((did+1))

			echo "$did : select setseed($seed)" >> $TS/datasets.log 2>&1
			echo "$did : $insert" >> $TS/datasets.log 2>&1
			echo "$did : create index idx on t(a $io) with (deduplicate_items=false)" >> $TS/indexes.log 2>&1

			psql test <<EOF
select setseed($seed);
$insert;
create index idx on t(a $io) with (deduplicate_items=false);
vacuum analyze t;
EOF

			relpages=$(psql -t -A test -c "select relpages from pg_class where relname = 't'")

			psql test -c "select * from t limit 10000" > $TS/samples/$ROWS-$step-$fuzz-$fuzz2.data 2>&1

			pg_ctl -D $DATADIR -l $TS/pg.log stop

			for iomethod in worker io_uring; do

				for ioworkers in 12; do

					for eic in 16; do

						for order in asc desc; do

							o=""
							if [ "$order" == "asc" ]; then
								o="ORDER BY a ASC"
							elif [ "$order" == "desc" ]; then
								o="ORDER BY a DESC"
							fi

							for run in $(seq 1 3); do

								values=1
								while /bin/true; do

									if [ "$values" -ge "$distinct" ]; then
										break;
									fi

									#for branch in master patched patched-geoghegan patched-geoghegan-munro patched-munro; do
									#for branch in master patched-728899ba patched-geoghegan-2-3ded1b78 patched-geoghegan-2-munro-3ded1b78 patched-geoghegan-43ff7415 patched-geoghegan-munro-43ff7415 patched-munro-728899ba; do
									#for branch in master patched-aio-nowait patched-aio-nowait-prefetch patched-aio-nowait-prefetch-cache patched-prefetch patched-prefetch-cache; do
									for branch in master patched patched-old patched-old-munro patched-munro; do

										qid=$((qid+1))

										PATH=/home/tomas/builds/$branch/bin:$PATH_OLD

										n=$((distinct - values - 1))
										start=$((RANDOM % n))
										end=$((start + values - 1))

										# flip the range, add minus
										if [ "$direction" == "decrease" ]; then
											end_new="-$start"
											start_new="-$end"

											start=$start_new
											end=$end_new
										fi

										sudo ./drop-caches.sh

										cp postgresql.conf $DATADIR

										echo "io_method = $iomethod" >> $DATADIR/postgresql.conf
										echo "io_workers = $ioworkers" >> $DATADIR/postgresql.conf

										echo "$qid : SELECT * FROM t WHERE a BETWEEN $start AND $end $o" >> $TS/queries.log 2>&1

										pg_ctl -D $DATADIR -l $TS/pg.log start

										echo "=========== DATASET: $did QUERY: $qid seed: $seed fillfactor: $fillfactor rows: $rows fuzz: $fuzz fuzz2: $fuzz2 step: $step iomethod: $iomethod ioworkers: $ioworkers eic: $eic iorder: $iorder order: $order build: $branch values: $values start: $start end: $end ===========" >> $TS/explains.log

										psql test > tmp.log 2>&1 <<EOF
SET enable_bitmapscan = off;
SET enable_seqscan = off;
SET max_parallel_workers_per_gather = 0;
SET effective_io_concurrency = $eic;
EXPLAIN (ANALYZE, COSTS OFF, TIMING OFF, VERBOSE, SETTINGS) SELECT * FROM t WHERE a BETWEEN $start AND $end $o;
EOF

										cat tmp.log >> $TS/explains.log

										time_uncached=$(grep '^ Execution Time:' tmp.log | awk '{print $3}')
										distance_uncached=$(grep 'Prefetch Distance' tmp.log | awk '{print $3}')

										buffers_hit=$(grep 'Buffers: shared' tmp.log | head -n 1 | awk '{print $3}' | sed 's/hit=//')
										buffers_read=$(grep 'Buffers: shared' tmp.log | head -n 1 | awk '{print $4}' | sed 's/read=//')

										if [ "$distance_uncached" == "" ]; then
											distance_uncached="-1"
										fi

										psql test > tmp.log 2>&1 <<EOF
SET enable_bitmapscan = off;
SET enable_seqscan = off;
SET max_parallel_workers_per_gather = 0;
SET effective_io_concurrency = $eic;
EXPLAIN (ANALYZE, COSTS OFF, TIMING OFF, VERBOSE, SETTINGS) SELECT * FROM t WHERE a BETWEEN $start AND $end $o;
EOF

										cat tmp.log >> $TS/explains.log

										time_cached=$(grep '^ Execution Time:' tmp.log | awk '{print $3}')
										distance_cached=$(grep 'Prefetch Distance' tmp.log | awk '{print $3}')

										if [ "$distance_cached" == "" ]; then
											distance_cached="-1"
										fi

										pg_ctl -D $DATADIR -l $TS/pg.log stop

										echo $did $qid $seed $fillfactor $ROWS $distinct $relpages $fuzz $fuzz2 $step $iomethod $ioworkers $eic $direction $run $iorder $order $branch $values $start $end $time_uncached $time_cached $distance_uncached $distance_cached $buffers_read $buffers_hit >> $TS/results.csv

									done

									m=$((distinct/10))
									if [ "$values" -ge "$m" ]; then
										values=$((values+m))
									else
										values=$((values*2))
									fi

								done

							done

						done

					done

				done

			done

		done

	done

done < $TS/parameters.random
