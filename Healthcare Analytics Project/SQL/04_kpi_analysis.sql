#OVERALL KPIS

SELECT COUNT(*) AS total_appointments,
SUM(completed_flag) AS completed_appointments, 
SUM(no_show_flag) AS no_shows, 
SUM(cancellation_flag) AS cancellations, 
ROUND(100.0* SUM(no_show_flag)/COUNT(*),2) AS no_show_rate, 
ROUND(100.0 * SUM(cancellation_flag)/COUNT(*),2) AS cancellation_rate, 
ROUND(AVG(CASE WHEN status = "Completed" THEN wait_time_minutes END), 2) AS avg_wait_minutes
FROM appointments; 