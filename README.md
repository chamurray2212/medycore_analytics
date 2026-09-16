# MedyCore Healthcare Operations Analytics

**SQL | Tableau | Healthcare Analytics | Operations Analytics**

## Project Overview

This project demonstrates an end-to-end healthcare operations analytics workflow using synthetic healthcare appointment and operational data.

The project focuses on analyzing appointment trends, patient attendance, clinic performance, and operational capacity to demonstrate how data analytics can support healthcare operations and performance reporting.

Using SQL for data querying and analysis and Tableau for interactive visualization, this project showcases skills relevant to healthcare data analyst, clinical data analyst, operations analyst, reporting analyst, and business intelligence analyst roles.

## Business Problem

Healthcare organizations need reliable reporting to understand appointment activity, identify operational trends, and monitor performance across clinics and departments.

This project explores how appointment and operational data can be used to answer questions such as:

- How does appointment volume change over time?
- What proportion of appointments are completed, cancelled, or missed?
- How do no-show and cancellation rates vary across clinics and departments?
- How does operational capacity compare with actual appointment volume?
- Which operational patterns may warrant further investigation?

The goal is to transform raw data into meaningful metrics and interactive visualizations that support operational decision-making.

## Dataset

This project uses **synthetic healthcare data** created for educational and portfolio purposes. The data does not represent real patients, healthcare providers, or actual clinical outcomes.

The project includes appointment-level and operational data, with fields such as:

| Data category | Example fields |
|---|---|
| Appointments | Appointment ID, patient ID, appointment date, status |
| Clinic information | Clinic, department |
| Appointment timing | Scheduled time, completion time, wait time |
| Operational data | Reporting week, capacity, operational volume |

The exact fields and reporting periods depend on the synthetic datasets used in the project.

## Tools and Technologies

- **MySQL:** Data querying, aggregation, validation, and analysis.
- **TablePlus:** Database management and SQL development.
- **Tableau:** Interactive dashboards, data visualization, and performance reporting.
- **Excel:** Supporting data review and organization, where applicable.

Python and Power BI are not included in the current project scope.

## Methodology

### 1. Data Preparation and Validation

Reviewed the synthetic datasets to understand their structure, field definitions, and relationships.

Data validation activities included:

- Checking for missing values and unexpected records.
- Reviewing appointment identifiers and potential duplicates.
- Confirming date and numeric data types.
- Reviewing appointment status categories.
- Validating that appointment and operational data could be analyzed at the appropriate level of detail.

### 2. SQL Analysis

Used MySQL to query and summarize the data for healthcare and operational performance reporting.

The analysis includes:

- Appointment volume and status summaries.
- Appointment completion, no-show, and cancellation metrics.
- Wait-time analysis.
- Clinic and department performance comparisons.
- Monthly appointment trends.
- Operational capacity and utilization analysis.

Metric definitions and denominators are documented to support consistent interpretation.

### 3. Tableau Visualization

Developed an interactive Tableau dashboard to present the analysis in a format suitable for healthcare operations reporting.

The dashboard includes:

- KPI summaries.
- Appointment volume trends.
- Clinic and department comparisons.
- Operational utilization visualizations.
- Interactive filters for exploring performance across reporting periods and healthcare settings.

The dashboard is designed to help users explore patterns and identify areas for further investigation.

## Dashboard

**Interactive Tableau Dashboard:** (https://public.tableau.com/app/profile/chakara.murray/vizzes)
Dashboard screenshots:
<img width="1440" height="900" alt="MedyCore Wait Time Analysis SS" src="https://github.com/user-attachments/assets/35edf546-a1cb-4190-98a1-65a6f867f04b" />
<img width="1440" height="900" alt="MedyCore Overview SS" src="https://github.com/user-attachments/assets/94116271-c706-44a3-90d1-d820afb953bc" />
<img width="1440" height="900" alt="MedyCore Capacity Analysis ScreenShot" src="https://github.com/user-attachments/assets/13382175-3e49-41bc-9e1f-a4d935175b3d" />


## Project Limitations

- The dataset is synthetic and does not represent actual patient populations or healthcare organizations.
- Results are intended to demonstrate analytical methods rather than establish real-world clinical or operational conclusions.
- Findings depend on the assumptions, field definitions, and reporting periods used in the project.
- The current version focuses on SQL and Tableau. Additional tools and analyses may be incorporated in future versions.

## Skills Demonstrated

- SQL querying and data aggregation.
- Data validation and quality checks.
- Healthcare appointment and operations analytics.
- KPI development and performance measurement.
- Data visualization and dashboard development.
- Interactive reporting and data storytelling.
- Translating analytical results into business-relevant insights.

## Future Enhancements

Potential future extensions include:

- Python-based exploratory data analysis and statistical analysis.
- Additional operational forecasting and trend analysis.
- Power BI dashboard development.
- Expanded documentation of analytical findings and business implications.

## Author

**Cha'Kara Murray**

Analytics professional with experience in operations research, clinical laboratory data analytics, and performance-focused environments.



