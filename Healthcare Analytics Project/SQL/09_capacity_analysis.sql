#Capacity Analysis

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


