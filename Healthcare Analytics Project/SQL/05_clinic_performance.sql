# CLINIC PERFORMANCE
 
SELECT clinic, 
COUNT(*) AS total_appointments,
SUM(completed_flag) AS completed, 
SUM(no_show_flag) AS no_shows, 
SUM(cancellation_flag) AS cancellations, 
ROUND(100.0*SUM(completed_flag)/COUNT(*),2) AS completion_rate, 
ROUND(100.0 * SUM(no_show_flag)/COUNT(*),2) AS no_show_rate, 
ROUND(AVG(CASE WHEN status = "Completed" THEN wait_time_minutes END), 2) AS avg_wait_minutes
FROM appointments
GROUP BY clinic
ORDER BY avg_wait_minutes DESC;


SELECT department,
COUNT(*) AS total_appointments,
ROUND(100.0 * SUM(no_show_flag)/COUNT(*), 2) AS no_show_rate,
ROUND(AVG(CASE WHEN status = "Completed" THEN wait_time_minutes END), 2) AS avg_wait_minutes
FROM appointments
GROUP BY department
ORDER BY avg_wait_minutes DESC; 


SELECT appointment_type,
COUNT(*) AS total_appointments,
ROUND(AVG(CASE WHEN status = "Completed" THEN wait_time_minutes END), 2) AS avg_wait_minutes,
ROUND(100.0*SUM(no_show_flag)/COUNT(*),2) AS no_show_rate
FROM appointments
GROUP BY appointment_type
ORDER BY avg_wait_minutes DESC; 