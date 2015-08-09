DROP TABLE IF EXISTS Weather;

CREATE TABLE Weather (
  Id          INT,
  Date        TIMESTAMP,
  Temperatute INT
);

INSERT INTO Weather (Id, Date, Temperatute) VALUES (1, '2015-01-01', 10);
INSERT INTO Weather (Id, Date, Temperatute) VALUES (2, '2015-01-02', 25);
INSERT INTO Weather (Id, Date, Temperatute) VALUES (3, '2015-01-03', 20);
INSERT INTO Weather (Id, Date, Temperatute) VALUES (4, '2015-01-04', 30);

SELECT temp.Id
FROM (
       SELECT
         w1.Id,
         (w1.Temperatute - w2.Temperatute) AS TempDiff
       FROM Weather AS w1 INNER JOIN Weather AS w2 ON (w1.Date - INTERVAL '1 day') = w2.Date
     ) AS temp
WHERE temp.TempDiff > 0
ORDER BY temp.TempDiff DESC;