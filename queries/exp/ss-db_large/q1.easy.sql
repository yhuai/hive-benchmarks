use ${DB};

EXPLAIN
SELECT SUM(v1),COUNT(*) FROM cycle
WHERE x BETWEEN 0 and 3750
AND   y BETWEEN 0 and 3750;

SELECT SUM(v1),COUNT(*) FROM cycle
WHERE x BETWEEN 0 and 3750
AND   y BETWEEN 0 and 3750;