 # WAIT TIME ANALYSIS 


WITH ranked_wait_times AS (
	SELECT wait_time_minutes, 
	ROW_NUMBER() OVER(ORDER BY wait_time_minutes) AS row_num, COUNT(*) OVER() AS total_rows
	FROM appointments
	WHERE status = "Completed")
	SELECT 
	MIN(wait_time_minutes) AS minimum_wait, 
	ROUND(AVG(wait_time_minutes),2) AS average_wait,
	ROUND(AVG(CASE WHEN row_num IN (FLOOR((total_rows + 1) *0.50), CEIL((total_rows + 1) *0.50)) THEN wait_time_minutes END), 2) AS median_wait,
	ROUND(AVG(CASE WHEN row_num IN (FLOOR((total_rows + 1) *0.75), CEIL((total_rows + 1) *0.75)) THEN wait_time_minutes END), 2) AS p75_wait,	
	ROUND(AVG(CASE WHEN row_num IN (FLOOR((total_rows + 1) *0.90), CEIL((total_rows + 1) *0.90)) THEN wait_time_minutes END), 2) AS p90_wait, 
	MAX(wait_time_minutes) AS maximum_wait
	FROM ranked_wait_times;



SELECT EXTRACT(HOUR FROM scheduled_time) AS appointment_hour,
COUNT(*) AS completed_visits,
ROUND(AVG(wait_time_minutes), 2) AS avg_wait
FROM appointments
WHERE status= "Completed"
GROUP BY appointment_hour
ORDER BY appointment_hour;


SELECT clinic, department,
COUNT(*) AS total_appointments,
ROUND(AVG(wait_time_minutes), 2) AS avg_wait,
ROUND(100.0 * SUM(no_show_flag)/COUNT(*), 2) AS no_show_rate
FROM appointments
GROUP BY clinic, department
ORDER BY avg_wait DESC; 