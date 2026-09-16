#Final Analysis


WITH appointment_metrics AS (
	SELECT clinic, department,
	COUNT(*) AS total_appointments,
	SUM(no_show_flag) AS no_shows,
	SUM(completed_flag) AS completed_appointments,
	ROUND(100.0* SUM(no_show_flag)/COUNT(*), 2) AS no_show_rate,	
	ROUND(100.0* SUM(completed_flag)/COUNT(*), 2) AS completion_rate,
	ROUND(AVG(CASE WHEN status = 'Completed' THEN wait_time_minutes END), 2) AS avg_wait_minutes
FROM appointments
GROUP BY clinic, department),
operations_metrics AS (
	SELECT clinic,
	SUM(scheduled_appointments) AS scheduled_appointments,
	SUM(available_slots) AS available_slots
FROM operations
GROUP BY clinic)
SELECT a.clinic, a.department, a.completed_appointments, a.no_shows, a.completion_rate, a.no_show_rate, a.avg_wait_minutes, 
ROUND(100.0 * o.scheduled_appointments/NULLIF(o.available_slots,0), 2) AS utilization_rate
FROM appointment_metrics AS a 
LEFT JOIN operations_metrics AS o
ON a.clinic = o.clinic
ORDER BY a.avg_wait_minutes DESC;   