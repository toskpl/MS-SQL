--zad16
SELECT count(*) AS proud_counts,
	FORMAT(approved_date, 'yyyy') AS approved_date
FROM protocol
GROUP BY FORMAT(approved_date, 'yyyy')
ORDER BY approved_date

--zad17
SELECT SUBSTRING(ro_number, 1, 2) AS ro_number,
	SUM(price) AS sum_price,
	AVG(price) AS avg_price,
	REPLACE(MIN(min_age) + '-' + MAX(max_age), 'years', '') AS age_groups
FROM protocol p
INNER JOIN product pr
	ON p.product_id = pr.product_id
WHERE ro_number IS NOT NULL
	AND ro_number LIKE '[a-z][a-z]%'
GROUP BY RO_NUMBER
ORDER BY 1


--zad 18
SELECT SUBSTRING(ro_number, 1, 2) AS ro_number,
	SUM(price) AS sum_price,
	AVG(price) AS avg_price,
	REPLACE(MIN(min_age) + '-' + MAX(max_age), 'years', '') AS age_groups
FROM protocol p
INNER JOIN product pr
	ON p.product_id = pr.product_id
WHERE ro_number IS NOT NULL
	AND ro_number LIKE '[a-z][a-z]%'
GROUP BY ro_number
HAVING SUM(price) > 300
	AND AVG(price) > 100
ORDER BY 1


