#NO SHOW ANALYSIS

SELECT clinic,
COUNT(*) AS total_appointments,
SUM(no_show_flag) AS no_shows,
ROUND(100.0 * SUM(no_show_flag)/COUNT(*),2) AS no_show_rate
FROM appointments
GROUP BY clinic
ORDER BY no_show_rate DESC;


SELECT appointment_type,
COUNT(*) AS total_appointments,
SUM(no_show_flag) AS no_shows,
ROUND(100.0 * SUM(no_show_flag)/COUNT(*),2) AS no_show_rate
FROM appointments
GROUP BY appointment_type
ORDER BY no_show_rate DESC;


SELECT CASE 
	WHEN days_between_scheduling <= 7 THEN "0-7 Days"
	WHEN days_between_scheduling <= 14 THEN "8-14 Days"
	WHEN days_between_scheduling <= 30 THEN "15-30 Days"
	WHEN days_between_scheduling <= 60 THEN "31-60 Days"
	ELSE "61+ Days" END AS lead_time_category,
COUNT(*) AS total_appointments,
SUM(no_show_flag) AS no_shows,
ROUND(100.0 *SUM(no_show_flag)/COUNT(*),2) AS no_show_rate
FROM appointments
GROUP BY lead_time_category
ORDER BY no_show_rate DESC;