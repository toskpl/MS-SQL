--zad11
SELECT p.prot_id,
	ps.secondary_id,
	s.type_id,
	NAME,
	valid
FROM protocol p
LEFT JOIN protocol_secondary_id ps
	ON p.prot_id = p.prot_id
LEFT JOIN secondary_id_types s
	ON s.type_id = ps.type_id


---zad12
CREATE TABLE Employee (
	EmployeeID INT,
	ManagerID INT,
	Title NVARCHAR(50)
	);

INSERT INTO Employee
VALUES (
	1,
	NULL,
	'Chief Executive Officer'
	);

INSERT INTO Employee
VALUES (
	2,
	1,
	'Engineering Manager'
	);

INSERT INTO Employee
VALUES (
	3,
	2,
	'Senior Tool Designer'
	);

INSERT INTO Employee
VALUES (
	4,
	2,
	'Design Engineer'
	);

INSERT INTO Employee
VALUES (
	5,
	2,
	'Research and Development'
	);

INSERT INTO Employee
VALUES (
	6,
	1,
	'Marketing Manager'
	);

INSERT INTO Employee
VALUES (
	7,
	6,
	'Marketing Specialist'
	);


SELECT e.*
FROM employee e
LEFT JOIN employee e2
	ON e2.employeeid = e.managerid
		--and e.EmployeeID is not null



---zad13
--SELECT count(*)
--FROM PROTOCOL

--SELECT count(*)
--FROM PROTOCOL_INTERVENTIONS

SELECT p.prot_id,
	p2.prot_id
FROM protocol p
LEFT JOIN protocol_interventions p2
	ON p.prot_id = p2.prot_id
		AND p2.prot_id IS NULL;

---zad14
--a
SELECT p.prot_id
FROM protocol p
WHERE EXISTS (
		SELECT p2.prot_id
		FROM protocol_interventions p2
		WHERE p.prot_id = p2.prot_id
		)

--b
SELECT p.prot_id
FROM protocol p
WHERE NOT EXISTS (
		SELECT p2.prot_id
		FROM protocol_interventions p2
		WHERE p.prot_id = p2.prot_id
		)

---zad15

SELECT prot_id FROM protocol
UNION
SELECT prot_id FROM protocol_outcome

SELECT prot_id FROM protocol
INTERSECT
SELECT prot_id FROM protocol_outcome

SELECT prot_id FROM protocol
EXCEPT
SELECT prot_id FROM protocol_outcome

WITH a
AS (
	SELECT prot_id
	FROM protocol
	UNION
	SELECT prot_id
	FROM protocol_outcome
	),
b
AS (
	SELECT prot_id
	FROM protocol
	INTERSECT
	SELECT prot_id
	FROM protocol_outcome
	),
c
AS (
	SELECT prot_id
	FROM protocol
	EXCEPT
	SELECT prot_id
	FROM protocol_outcome
	)
SELECT a.prot_id,
	b.prot_id,
	c.prot_id
FROM a
LEFT JOIN b
	ON a.prot_id = b.prot_id
LEFT JOIN c
	ON a.prot_id = c.prot_id;
