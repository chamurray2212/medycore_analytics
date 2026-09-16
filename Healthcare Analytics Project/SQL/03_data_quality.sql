SELECT *
FROM appointments ; 

SELECT *
FROM appointments
ORDER BY appointment_date
LIMIT 10; 

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