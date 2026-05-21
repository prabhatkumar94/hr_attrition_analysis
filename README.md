# 🏢 HR Attrition Analysis

**Identifying Why Employees Are Leaving — TalentCore Solutions**

---

## 📌 Project Overview

This project analyzes IBM HR Analytics Employee Attrition data 
of 1,470 employees to identify the root causes of 16.12% annual 
attrition rate at TalentCore Solutions — significantly above the 
healthy industry benchmark of 10%.

The workflow includes **EDA in Python**, **SQL analysis in MySQL**, 
and **interactive 3-page dashboard in Power BI**.

---

## 🎯 Business Problem

TalentCore Solutions is losing 16% of employees annually.
Each lost employee costs Rs 50,000 in replacement.
Total annual cost = Rs 1,18,50,000.

The HR department lacks visibility into:
- WHO is leaving the company
- WHY they are choosing to leave
- WHEN they tend to leave

---

## 🗂️ Dataset Information

- **Source:** IBM HR Analytics Employee Attrition — Kaggle
- **Rows:** 1,470 employees
- **Columns:** 32 features
- **Null Values:** None
- **Target Variable:** Attrition (Yes/No)

---

## ❓ Business Questions Analyzed (16 Total)

### WHO Is Leaving?
- Which age group has the highest attrition?
- Which department has the highest attrition rate?
- Which job role has the most attrition?
- Which education field has the most attrition?

### WHY Are They Leaving?
- Do employees with low monthly income leave more?
- Does overtime lead to higher attrition?
- Which work life balance level has highest attrition?
- Do employees with no stock options leave more?
- Does environment satisfaction affect attrition?
- Which performance rating group leaves most?

### WHEN Do They Leave?
- After how many years do employees leave most?
- Does lack of promotion lead to attrition?
- Does having a new manager lead to attrition?
- Which business travel frequency has highest attrition?
- Do employees who worked at more companies leave sooner?

### Base Metric
- What is the overall attrition rate?

---

## 🔍 Key Findings

| Finding | Attrition Rate |
|---|---|
| Sales Representative | 39.76% — Highest Role |
| Age Group 18-25 | 34.78% — Highest Age Group |
| Overtime = Yes | 30.53% — 3x higher than No |
| New Joiners (0-2 yrs) | 29.82% — Critical period |
| New Manager (0-1 yr) | 28.32% — Manager change risk |
| No Stock Options | 24.41% — Financial retention gap |
| Low Environment Sat. | 25.35% — Culture issue |
| Sales Department | 20.63% — Highest Department |

---

## 💡 Top Insights

- Overtime employees leave at **3x the rate** of non-overtime employees
- Employees who left earned **Rs 4,787/month** vs Rs 6,832 for those who stayed — a **Rs 2,045 salary gap**
- First **2 years at company** and first **year with new manager** are the most critical risk periods
- **Sales Representatives** have nearly **40% attrition** — almost 4 in 10 leave

---

## 🚀 Recommendations

### Immediate (0-3 Months)
- Cap overtime at 10 hours/week
- Conduct salary review for Sales team
- Close Rs 2,045 income gap

### Short Term (3-6 Months)
- Redesign onboarding for new joiners
- Manager training on retention skills
- Expand stock option program

### Long Term (6-12 Months)
- Flexible work life balance policy
- Special retention program for Sales
- Maximum 2-3 year promotion cycle

---

## 📊 Business Impact

| Metric | Value |
|---|---|
| Current Attrition Rate | 16.12% |
| Target Attrition Rate | Under 10% |
| Employees Saved | ~90 per year |
| Projected Annual Savings | Rs 45,00,000 |

---

## 🛠️ Tools & Technologies

- **Python** — Pandas
- **MySQL** — Business queries, Window Functions, CTEs
- **Power BI** — 3-page interactive dashboard, DAX measures
- **Gamma AI** — Project presentation

---

## 📁 Project Files

| File | Description |
|---|---|
| hr_attrition_EDA.ipynb | Python EDA notebook |
| hr_attrition_analysis.sql | 16 SQL business queries |
| hr_attrition_dashboard.pbix | Power BI dashboard |
| HR_Attrition_Project_question_final.pdf | Business questions PDF |
| HR-Attrition-Analysis_Report.pdf | Final presentation |
| WA_Fn-UseC_-HR-Employee-Attrition.csv | Dataset |

---

## 👨‍💻 Created By

- **Name:** Prabhat Kumar
- **Role:** Junior Data Analyst
- **Email:** kumarprabhat94317@gmail.com


---

## ⭐ If you like this project

Give it a star and feel free to fork it!
