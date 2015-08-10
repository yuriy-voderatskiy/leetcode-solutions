DROP TABLE IF EXISTS Person;

CREATE TABLE Person (
  Id    INT PRIMARY KEY,
  Email TEXT
);

INSERT INTO Person (Id, Email) VALUES (1, 'john@example.com');
INSERT INTO Person (Id, Email) VALUES (2, 'bob@example.com');
INSERT INTO Person (Id, Email) VALUES (3, 'john@example.com');

DELETE FROM Person
WHERE Person.Id NOT IN (SELECT MIN(Id)
                        FROM Person
                        GROUP BY Email);

SELECT
  Id,
  Email
FROM Person;
