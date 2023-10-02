SELECT
  EXTRACT(YEAR FROM functions.string_to_date(s.EventDate)) AS year,
  EXTRACT(MONTH FROM functions.string_to_date(s.EventDate)) AS month,
  COUNT(s.EventType) AS Sent,
  COUNT(c.EventType) AS Spam
FROM
  `ninth-osprey-782.exact_target_raw.sent_*` s
LEFT JOIN 
  `ninth-osprey-782.exact_target_raw.complaints_*` c
ON
  s.BatchID = c.BatchID
WHERE
  functions.string_to_date(s.EventDate) BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 365 DAY)
  AND CURRENT_DATE 
GROUP BY 1,2
ORDER BY 1,2