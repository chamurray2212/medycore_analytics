#SETUP

CREATE TABLE appointments
 (
    appointment_id VARCHAR(20),
    patient_id VARCHAR(20),
    clinic VARCHAR(50),
    department VARCHAR(50),
    provider_id VARCHAR(20),
    appointment_date DATE,
    appointment_type VARCHAR(50),
    scheduled_time TIMESTAMP,
    check_in_time TIMESTAMP,
    appointment_start TIMESTAMP,
    appointment_end TIMESTAMP,
    status VARCHAR(20),
    cancellation_reason VARCHAR(100),
    payer_type VARCHAR(30),
    patient_age INTEGER,
    days_between_scheduling INTEGER,
    wait_time_minutes NUMERIC,
    visit_duration_minutes NUMERIC,
    day_of_week VARCHAR(20),
    month VARCHAR(20),
    quarter VARCHAR(5),
    no_show_flag INTEGER,
    cancellation_flag INTEGER,
    completed_flag INTEGER,
    late_arrival_flag INTEGER,
    same_day_appointment_flag INTEGER
);

#IMPORT VERIFICATION

SELECT COUNT(*)
FROM appointments;

SELECT *
FROM appointments
LIMIT 10; 


#DATA QUALITY

SELECT appointment_id, COUNT(*) AS record_count
FROM appointments
GROUP BY appointment_id
HAVING COUNT(*) >1 ;

SELECT COUNT(*) AS missing_appoinment_id 
FROM appointments
WHERE appointment_id IS NULL;

SELECT 
	SUM(CASE WHEN appointment_id IS NULL THEN 1 ELSE 0 END) AS missing_appointment_id,
	SUM(CASE WHEN patient_id IS NULL THEN 1 ELSE 0 END) AS missing_patient_id,
	SUM(CASE WHEN clinic IS NULL THEN 1 ELSE 0 END) AS missing_clinic,
	SUM(CASE WHEN department IS NULL THEN 1 ELSE 0 END) AS missing_department,
	SUM(CASE WHEN appointment_date IS NULL THEN 1 ELSE 0 END) AS missing_date,
	SUM(CASE WHEN status IS NULL THEN 1 ELSE 0 END) AS missing_status
FROM appointments;

SELECT 
	status,
	COUNT(*) as appointment_count
FROM appointments
GROUP BY status 
ORDER BY appointment_count DESC; 

SELECT DISTINCT clinic
FROM appointments
ORDER BY clinic 

SELECT DISTINCT department
FROM appointments
ORDER BY department


#OVERALL KPIS

SELECT COUNT(*) AS total_appointments,
SUM(completed_flag) AS completed_appointments, 
SUM(no_show_flag) AS no_shows, 
SUM(cancellation_flag) AS cancellations, 
ROUND(100.0* SUM(no_show_flag)/COUNT(*),2) AS no_show_rate, 
ROUND(100.0 * SUM(cancellation_flag)/COUNT(*),2) AS cancellation_rate, 
ROUND(AVG(CASE WHEN status = "Completed" THEN wait_time_minutes END), 2) AS avg_wait_minutes
FROM appointments; 

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

#WAIT TIME ANALYSIS

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

#TREND ANALYSIS
	
SELECT DATE_FORMAT(appointment_date, '%Y,%m') AS month,
COUNT(*) AS total_appointments,
SUM(completed_flag) AS completed,
SUM(no_show_flag) AS no_shows,
SUM(cancellation_flag) AS cancellations,
ROUND(100.0 * SUM(no_show_flag)/COUNT(*), 2) AS no_show_rate,
ROUND(AVG(CASE WHEN status = "Completed" THEN wait_time_minutes END), 2) AS avg_wait
FROM appointments
GROUP BY DATE_FORMAT(appointment_date, '%Y,%m')
ORDER BY month;


#CAPACITY ANALYSIS

SELECT clinic,
SUM(scheduled_appointments) AS scheduled_appointments,
SUM(available_slots) AS available_slots,
ROUND (100.0 * SUM(scheduled_appointments)/NULLIF(SUM(available_slots), 0), 2) AS utilization_rate,
ROUND(AVG(avg_wait_minutes), 2) AS avg_wait
FROM operations
GROUP BY clinic
ORDER BY utilization_rate DESC; 


SELECT clinic,
ROUND (100.0 * SUM(scheduled_appointments)/NULLIF(SUM(available_slots), 0), 2) AS utilization_rate,
ROUND(AVG(avg_wait_minutes), 2) AS avg_wait,
CASE 
	WHEN 
	100.0 * SUM(scheduled_appointments)/NULLIF(SUM(available_slots),0) >=90 AND AVG(avg_wait_minutes) >= 20 THEN 'High Risk'
	WHEN 
	100.0 * SUM(scheduled_appointments)/NULLIF(SUM(available_slots),0) >=85 AND AVG(avg_wait_minutes) >= 15 THEN 'Medium Risk'
	ELSE 'Low Risk'
	END AS operational_risk
FROM operations
GROUP BY clinic
ORDER BY utilization_rate DESC;


#FINAL ANALYSIS


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