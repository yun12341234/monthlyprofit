WITH #monthly AS (
    SELECT jmjm1.jobdate, jmjm2.jobno, jmjm2.amt, jmjm2.costamt
    FROM jmjm2 
    JOIN jmjm1 ON jmjm2.jobno = jmjm1.jobno
    WHERE jmjm1.jobdate >= '01-01-2023'
)

SELECT DISTINCT m.jobdate,
    SUM(m.amt) OVER (PARTITION BY m.jobdate) AS Salesamt,
    SUM(m.costamt) OVER (PARTITION BY m.jobdate) AS salesamt,
    (SUM(m.amt) OVER (PARTITION BY m.jobdate) - SUM(m.costamt) OVER (PARTITION BY m.jobdate)) AS profit
FROM #monthly AS m
ORDER BY m.jobdate;
