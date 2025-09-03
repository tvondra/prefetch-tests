#!/usr/bin/env bash

MACHINE=$1

rm -f results.db

rm -Rf $MACHINE
mkdir $MACHINE

sqlite3 results.db <<EOF
CREATE TABLE results (did INT, qid INT, seed numeric, fillfactor INT, rows int, ndistinct int, relpages int, fuzz int, fuzz2 int, step int, iomethod text, ioworkers int, eic int, direction text, run int, index_order text, scan_order text, branch text, num_values int, start int, end int, time_uncached numeric, time_cached numeric, distance_uncached numeric, distance_cached numeric, buffers_read int, buffers_hit int);
CREATE INDEX results_idx ON results(did, qid, fillfactor, rows, ndistinct, relpages, fuzz, fuzz2, step, iomethod, ioworkers, eic, direction, run, index_order, scan_order, branch, num_values);
.mode csv
.separator ' '
.import --skip 1 ${MACHINE}.csv results
EOF

sqlite3 results.db <<EOF
CREATE VIEW results_agg AS
SELECT
    did, fillfactor, rows, ndistinct, relpages, fuzz, fuzz2, step, iomethod, ioworkers, eic, direction, index_order, scan_order, branch, num_values,
    COUNT(*) AS cnt,
    -- MIN(qid) AS qid,
    group_concat(qid, ',') AS qid,
    AVG(time_uncached) AS avg_time
FROM results
GROUP BY did, fillfactor, rows, ndistinct, relpages, fuzz, fuzz2, step, iomethod, ioworkers, eic, direction, index_order, scan_order, branch, num_values;

CREATE VIEW branches AS
SELECT
    did, fillfactor, rows, ndistinct, relpages, fuzz, fuzz2, step, iomethod, ioworkers, eic, branch, num_values,
    SUM(cnt) AS cnt,
    group_concat(qid, ',') AS query_ids,
    MIN(avg_time) AS min_time,
    MAX(avg_time) AS max_time,
    AVG(avg_time) AS avg_time
FROM results_agg
GROUP BY did, fillfactor, rows, ndistinct, relpages, fuzz, fuzz2, step, iomethod, ioworkers, eic, branch, num_values;

CREATE VIEW directions AS
SELECT
    did, fillfactor, rows, ndistinct, relpages, fuzz, fuzz2, step, iomethod, ioworkers, eic, direction, index_order, scan_order, num_values,
    SUM(cnt) AS cnt,
    group_concat(qid, ',') AS query_ids,
    MIN(avg_time) AS min_time,
    MAX(avg_time) AS max_time,
    AVG(avg_time) AS avg_time
FROM results_agg
GROUP BY did, fillfactor, rows, ndistinct, relpages, fuzz, fuzz2, step, iomethod, ioworkers, eic, direction, index_order, scan_order, num_values;
EOF

sqlite3 results.db > $MACHINE/branches.txt <<EOF
.mode table
SELECT *, round(100 * ((max_time - min_time) / avg_time), 2) AS pct_diff FROM branches ORDER BY (max_time - min_time) / avg_time DESC
EOF

sqlite3 results.db > $MACHINE/directions.txt <<EOF
.mode table
SELECT *, round(100 * ((max_time - min_time) / avg_time), 2) AS pct_diff FROM directions ORDER BY (max_time - min_time) / avg_time DESC
EOF

sqlite3 results.db > branches.tmp <<EOF
.mode csv
SELECT DISTINCT branch FROM results ORDER BY branch
EOF

while IFS= read -r b1; do

	b1=$(echo $b1 | tr -d '\r')

	while IFS= read -r b2; do

		b2=$(echo $b2 | tr -d '\r')

		if [ "$b1" == "$b2" ]; then
			continue
		fi

		sqlite3 results.db <<EOF
DROP VIEW IF EXISTS regressions;
CREATE VIEW regressions AS
SELECT
    did, fillfactor, rows, ndistinct, relpages, fuzz, fuzz2, step, iomethod, ioworkers, eic, direction, index_order, scan_order, num_values,
    round(m.avg_time,2) AS "$b1",
    round(p.avg_time,2) AS "$b2",
    (m.cnt + p.cnt) AS cnt,
    concat(m.qid, ',', p.qid) AS qid
FROM results_agg m
JOIN results_agg p USING (did, fillfactor, rows, ndistinct, relpages, fuzz, fuzz2, step, iomethod, ioworkers, eic, direction, index_order, scan_order, num_values)
WHERE m.branch = '$b1'
  AND p.branch = '$b2';
EOF

		sqlite3 results.db > $MACHINE/$b1-$b2-relative.txt <<EOF
.mode table
SELECT *, round(100 * (("$b2" - "$b1") / "$b1"), 2) AS pct_diff FROM regressions ORDER BY (("$b2" - "$b1") / "$b1") DESC
EOF

		sqlite3 results.db > $MACHINE/$b1-$b2-absolute.txt <<EOF
.mode table
SELECT *, round("$b2" - "$b1",2) AS diff, round(100 * (("$b2" - "$b1") / "$b1"), 2) AS pct_diff FROM regressions ORDER BY ("$b2" - "$b1") DESC
EOF

	done < branches.tmp

done < branches.tmp
