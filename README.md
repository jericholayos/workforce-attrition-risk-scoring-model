# HR Employee Attrition Analysis
[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-18-blue?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Power BI](https://img.shields.io/badge/Power%20BI-Desktop-yellow?logo=powerbi&logoColor=black)](https://powerbi.microsoft.com/)

**Tools:** PostgreSQL 18 · Power BI Desktop  
**Dataset:** Publicly available HR Analytics dataset - [Kaggle](https://www.kaggle.com/datasets/pavansubhasht/ibm-hr-analytics-attrition-dataset)  
**Records:** 1,470 employees · 35 columns

---

## Overview
End-to-end data analysis project identifying the key drivers of employee attrition. SQL was used for exploratory data analysis and deep-dive querying. Power BI was used to build an interactive 2-page dashboard presenting findings to a non-technical audience.

The overall attrition rate is **16.12%** (237 out of 1,470 employees).

---

## Key Findings

- **Overtime is the strongest driver** - overtime employees leave at 30.53% vs 10.44% for non-overtime, nearly a 3x difference
- **Sales Representative** is the highest-risk role at 39.76% attrition, nearly 2 in 5 left
- **Leavers earn significantly less** - the HR department shows the largest income gap at $3,630/month between leavers and stayers
- **Early tenure is critical** - employees in their first 0-2 years leave at 29.82%
- **No stock options = higher attrition** - level 0 employees leave at 24.41% vs 9.40% for level 1
- **Single employees** leave at 25.53% vs 12.48% for married employees

---

## Dashboard

**Page 1 - Executive Overview**
- KPI cards: Total Employees, Total Attrition, Attrition Rate, Average Tenure
- Attrition Rate by Overtime
- High At-Risk Roles table
- Attrition Rate by Department
- Workforce Composition donut
- Average Monthly Income by Attrition & Department
<img width="1416" height="793" alt="Executive Overview" src="https://github.com/user-attachments/assets/597895f2-9b20-4461-937e-8e52a3856dde" />

---

**Page 2 - Employee Deep Dive**
- KPI cards: High Risk Count, Avg Performance Rating, Avg Job Satisfaction Rating, Overtime Attrition %
- Income Gap by Job Role: Leavers vs Stayers
- Attrition Rate by Stock Option Level
- Attrition Rate by Marital Status
- Attrition Rate by Age Group
- Attrition Rate by Tenure Group
<img width="1421" height="795" alt="image" src="https://github.com/user-attachments/assets/6e9446fb-be0b-4054-a6ba-3125188a57f3" />


---

## Files

| File | Description |
|---|---|
| `all_queries.sql` | All SQL queries - EDA, deep dive, window functions, risk scoring |
| `Dashboard.pbix` | Power BI dashboard file |
| `HR-Employee-Attrition.csv` | Source dataset |

---

## SQL Highlights

- Used CTEs to compare attrition rates across departments
- Used window functions to rank roles by attrition and track cumulative turnover by tenure
- Built a risk scoring model to identify employees most likely to leave based on multiple attrition factors
- Analyzed how overtime and job satisfaction interact to drive attrition

---

## Limitations

- No date columns - analysis is a snapshot, no trend tracking possible
- Synthetic dataset - does not represent real employee data
- Findings are correlational, not causal
- Small subgroups (HR dept = 63 employees) should be interpreted with caution
