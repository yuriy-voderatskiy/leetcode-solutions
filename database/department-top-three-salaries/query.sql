DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS Department;

CREATE TABLE Employee (
  Id           INT PRIMARY KEY,
  Name         TEXT,
  Salary       INT,
  DepartmentId INT
);

CREATE TABLE Department (
  Id   INT PRIMARY KEY,
  Name TEXT
);

INSERT INTO Employee (Id, Name, Salary, DepartmentId)
VALUES (1, 'Joe', 70000, 1);
INSERT INTO Employee (Id, Name, Salary, DepartmentId)
VALUES (2, 'Henry', 80000, 2);
INSERT INTO Employee (Id, Name, Salary, DepartmentId)
VALUES (3, 'Sam', 60000, 2);
INSERT INTO Employee (Id, Name, Salary, DepartmentId)
VALUES (4, 'Max', 90000, 1);
INSERT INTO Employee (Id, Name, Salary, DepartmentId)
VALUES (5, 'Janet', 69000, 1);
INSERT INTO Employee (Id, Name, Salary, DepartmentId)
VALUES (6, 'Randy', 85000, 1);

INSERT INTO Department (Id, Name) VALUES (1, 'IT');
INSERT INTO Department (Id, Name) VALUES (2, 'Sales');

SELECT
  emp.Id,
  emp.Name,
  emp.Salary,
  dep.Name
FROM Employee AS emp
  INNER JOIN Department AS dep ON emp.DepartmentId = dep.Id;


SELECT count(*)
FROM Employee AS e1 LEFT JOIN Employee AS e2 ON e1.Id = e2.Id
GROUP BY e2.DepartmentId;

SELECT *
FROM Employee AS e1 JOIN Employee AS e2
    ON e1.Salary > e2.Salary AND e1.DepartmentId = e2.DepartmentId;

SELECT e1.*
FROM Employee AS e1
  JOIN Employee AS e2
    ON e1.DepartmentId = e2.DepartmentId
GROUP BY e1.DepartmentId
ORDER BY e1.Salary DESC;

-- Using Postgres window functions
SELECT
  Dep.Name AS Department,
  Emp.Name AS Employee,
  Emp.Salary
FROM (SELECT
        Id,
        DepartmentId,
        rank()
        OVER (PARTITION BY DepartmentId
          ORDER BY Salary DESC) AS Rank
      FROM Employee) AS Ranks
  JOIN Department AS Dep ON Ranks.DepartmentId = Dep.Id
  JOIN Employee AS Emp ON Ranks.Id = Emp.Id
WHERE Ranks.Rank <= 3;

-- Using generic SQL
SELECT
  d.Name   AS Department,
  e.Name   AS Employee,
  e.Salary AS Salary
FROM Employee AS e INNER JOIN
  (SELECT
     a.Id,
     count(*) AS rank
   FROM Employee AS a
     JOIN Employee AS b
       ON (a.DepartmentId = b.DepartmentId) AND (a.Salary <= b.Salary)
   GROUP BY a.Id
   HAVING COUNT(*) <= 3
   ORDER BY a.Salary DESC) AS ranking ON e.Id = ranking.Id
  INNER JOIN Department AS d ON e.DepartmentId = d.Id
ORDER BY e.DepartmentId, e.Salary DESC;



