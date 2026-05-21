CREATE DATABASE IF NOT EXISTS hr_attrition_analysis;
USE hr_attrition_analysis;


SELECT COUNT(*) FROM hr_attrition;
SELECT * FROM hr_attrition LIMIT 100;

-- Q1.What is the overall attrition rate of the company? How many employees left and how many stayed?


SELECT 
	COUNT(*) AS TOTAL_EMPLOYEE,
	SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END) AS EMPLOYEES_LEFT,
    SUM(CASE WHEN Attrition = 'NO' THEN 1 ELSE 0 END) AS EMPLOYEES_STAYED,
    ROUND(SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END)/COUNT(*)*100 ,2 ) AS RATE_OF_ATTRITION
FROM hr_attrition;

-- Business Problem : The company has no visbility into its overall attrition rate, making it impossible to measure employee retention or set improvement target.
-- Impact :
          -- Establishes the baseline metrics for all attrition analysis.
          -- Helps leadership to set the realistic retention target.
          -- Identify urgency of the retention problem.
          
-- Q2.Which department has the highest attrition rate?
SELECT * FROM hr_attrition LIMIT 100;

SELECT Department,
COUNT(*) AS TOTAL_IN_DEPT,
SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END) AS LEFT_DEPT,
ROUND(SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END)/COUNT(*)*100,2) AS Attrition_Rate
FROM hr_attrition
GROUP BY Department
ORDER BY Attrition_Rate DESC;

-- Business Problem : Without department level attrition visibility, the company cannot identify which teams are most at risk,leading to blanket retention strategies that waste the resources.
-- Impact :
          -- Identifies high risk department for immediate action.
          -- Enables targeted retention strategies per department.
          -- Helps HR conduct focused surveys in critical departments.

-- Q3.Which job role has the highest attrition rate?
SELECT * FROM hr_attrition LIMIT 100;

SELECT JobRole,
COUNT(*) AS TOTAL_EMP,
SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END) AS EMP_LEFT,
ROUND(SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END)/COUNT(*)*100,2) AS Attrition_Rate
FROM hr_attrition
GROUP BY JobRole
ORDER BY Attrition_Rate DESC
LIMIT 5;

-- Business Problem: The company lacks role-specific attrition data, making it impossible to identify whether certain job roles are structurally problematic in terms of retention.

-- Impact:
		  -- Identifies high risk department for immediate action.
          -- Enables HR to proactively plan recruitment pipeline for high attrition roles like Sales Representative to avoid understaffing risks.
          -- Allows compensation team to benchmark salaries across job roles and identify if pay disparity is driving attrition in specific positions.
          -- Helps identify if early career employees in high attrition roles need stronger onboarding and mentorship programs.

-- Q4.Do employees with low monthly income leave more? Show average income of employees who left vs who stayed.
SELECT * FROM hr_attrition LIMIT 100;

SELECT Attrition,
COUNT(*) AS TOTAL_EMP,
ROUND(AVG(MonthlyIncome),2) AS AVG_INCOME
FROM hr_attrition
GROUP BY Attrition;

-- Business Problem: The company has no visibility into whether compensation levels are driving attrition, making it impossible to determine if salary dissatisfaction is a key reason employees are leaving.

-- Impact:
		  -- Finance team re-considered the salary structure of employees who left
          -- HR teams should consider the new roles with high salary compensation.
          -- Enables leadership to set minimum salary benchmarks to reduce financial dissatisfaction driven attrition.
 
-- Q5.Which work life balance level has the highest attrition rate?.
SELECT * FROM hr_attrition LIMIT 100;

SELECT 
CASE WorkLifeBalance
		WHEN 1 THEN 'Bad'
        WHEN 2 THEN 'Good'
        WHEN 3 THEN 'Better'
        WHEN 4 THEN 'Best'
 END AS WLB_Level,
COUNT(*) AS TOTAL_EMP,
SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END) AS TOTAL_LEFT_EMP,
ROUND(SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END)/COUNT(*)*100,2) AS ATTRITION_RATE
FROM hr_attrition
GROUP BY WLB_Level
ORDER BY WLB_Level;

-- Business Problem: The company cannot identify whether poor work life balance is driving attrition, making it impossible to design effective employee wellness and flexibility programs.
-- Impact:
		  -- Enables HR to prioritize mental health for employees reporting low work life balance levels, directly targeting the highest risk group first
          -- companies should implement flexible scheduling, enforce strict "disconnect" policies to respect personal time, and actively promote mental health resources
          -- Company should take employees regular feedback about their mental wellness , work , life and if need give them counselling.

-- Q6. Does lack of promotion lead to attrition? Show attrition rate based on years since last promotion.

SELECT DISTINCT(YearsSinceLastPromotion)
FROM hr_attrition;

SELECT 
	CASE 
		WHEN YearsSinceLastPromotion >= 0 AND YearsSinceLastPromotion <= 2 THEN '0-2 YRS' 
        WHEN YearsSinceLastPromotion > 2 AND YearsSinceLastPromotion <= 5 THEN '2-5 YRS' 
        WHEN YearsSinceLastPromotion >5 AND YearsSinceLastPromotion <= 7 THEN '5-7 YRS' 
        ELSE '7+ YRS' 
    END AS LST_PROMO_BUCKET,
    COUNT(*) AS TOTAL_EMP,
    SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END) AS TOTAL_LEFT_EMP,
	ROUND(SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END)/COUNT(*)*100,2) AS ATTIRTION_RATE
    FROM hr_attrition
    GROUP BY LST_PROMO_BUCKET
    ORDER BY ATTIRTION_RATE DESC;
    
-- Business Problem: Company can not identify that whether the delayed promotions are contributing to attrition, making it impossible to design a fair and timely pomotion policy that retains high performing employees.
-- Impact: 
		  -- Enables HR to establish a maximum 2-3 year promotion cycle to prevent dissatisfaction and attrition among high performing employees
          -- Helps managers identify employees who have been in same role for more than 5 years are at risk of Attrition.
          -- Allows company to create clear promotion criteria so employees have visibility into their career path.

-- Q7. Do employees with no stock options leave more? Show attrition rate by stock option level.

select distinct(StockOptionLevel) from hr_attrition;

SELECT 
	CASE StockOptionLevel
    WHEN 0 THEN 'NO STOCK'
    WHEN 1 THEN 'LOW'
    WHEN 2 THEN 'MEDIUM'
    WHEN 3 THEN 'HIGH'
    END AS STOCK_LVL,
    COUNT(*) AS TOTAL_EMP,
    SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END) AS LEFT_EMP,
    ROUND(SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END) / COUNT(*)*100,2) AS Attrititon_Rate
    FROM hr_attrition
    GROUP BY STOCK_LVL
    ORDER BY Attrititon_Rate DESC;
    
    -- Business Problem: The company has no visibility into whether stock option allocation is impacting employee retention, making it impossible to evaluate stock options as a financial retention tool.
	-- Impact: 
		  -- Enables company to prioritize stock option allocation for no-stock employees (24.41% attrition) as an immediate retention strategy.
          -- Helps HR design a phased compensation plan starting with performance bonuses and progressing to stock options — to financially engage and retain at-risk employees.
          -- Highlights that stock options alone are not sufficient for retention — high stock employees (17.65% attrition) suggest other factors like growth opportunities, job satisfaction and manager relationships also need to be addressed.

-- Q8. Which performance rating group leaves the most? Show attrition rate by performance rating.

SELECT 
	CASE PerformanceRating
		WHEN 3 THEN 'EXCELLENT'
        WHEN 4 THEN 'OUTSTANDING'
	END AS PERFORMANCE_RATING,
COUNT(*) AS TOTAL_EMP,
SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END) AS TOTAL_LEFT,
ROUND(SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END)/COUNT(*) * 100,2) AS Attrition_Rate
FROM hr_attrition
GROUP BY PERFORMANCE_RATING
ORDER BY Attrition_Rate DESC;

-- Business Problem: The company cannot determine whether performance rating is a driving factor of attrition, making it difficult to identify if low performers or  high performers are more likely to leave.
-- Impact: 
		  --  Helps understand that if lower rated employees have high attrition it is expected, but if higher rated employees are also leaving then company must investigate other factors immediately.
		  -- Helps HR shift focus from performance based retention strategies to other factors like salary, growth and work life balance which may have stronger impact.
          -- Since only 2 performance rating values exist with similar attrition rates, performance rating alone is not a reliable predictor of attrition and company should consider a broader rating system.

-- Q9. Which education field has the most attrition? Show top 3 education fields with highest attrition rate.

SELECT 
	EducationField,
	COUNT(*) AS TOTAL_EMP,
    SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END ) AS EMP_LEFT,
    ROUND( SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END )/COUNT(*)*100,2) AS Attrition_Rate
    FROM hr_attrition
    GROUP BY EducationField
    ORDER BY Attrition_Rate DESC
    LIMIT 3;
    
-- Business Problem:The company can not determine whether the educational field is a factor of high attrition , making it difficult to find which educational field has higher attrition.
-- Impact: 
	  -- Helps company identify that all three high attrition education fields have strong market demand, requiring  competitive salary benchmarking to stay relevant.
      -- Technical degree employees are likely leaving for  salary hikes elsewhere — company should conduct regular salary reviews for these roles.
      -- Company should focus on employee growth by offering learning programs, clear career growth paths and other retention facilities for high attrition education groups.
		
-- Q10. Does overtime lead to higher attrition? Show attrition rate for employees who do overtime vs who don't.

select distinct(OverTime) from hr_attrition;

SELECT 
	OverTime ,
	COUNT(*) as TOTAL_EMP,
	SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END ) AS EMP_LEFT,
    ROUND( SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END )/COUNT(*)*100,2) AS Attrition_Rate
    FROM hr_attrition
    GROUP BY OverTime
    ORDER BY Attrition_Rate DESC;

-- Business Problem: The company has no visibility into whether mandatory overtime is burning out employees and directly contributing to attrition, making it impossible to design a healthy workload policy.
-- Impact: 
	  -- Enables company to set strict overtime limits and introduce overtime compensation to reduce burnout driven attrition.
      -- With 30 out of 100 overtime employees leaving, unmanaged overtime poses a serious business risk requiring immediate policy intervention.
      -- Overtime induced burnout is directly linked to attrition — company must monitor workload distribution and introduce mandatory rest policies to protect employee wellbeing.
      
-- Q11. Does environment satisfaction affect attrition? Show attrition rate by environment satisfaction level.

SELECT 
CASE EnvironmentSatisfaction
	WHEN 1 THEN 'LOW'
    WHEN 2 THEN 'MEDIUM'
    WHEN 3 THEN 'HIGH'
    WHEN 4 THEN 'VERY HIGH'
    END AS ENV_RATING,
COUNT(*) AS TOTAL_EMP,
SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END ) AS EMP_LEFT,
ROUND( SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END )/COUNT(*)*100,2) AS Attrition_Rate
FROM hr_attrition
GROUP BY ENV_RATING
ORDER BY Attrition_Rate DESC;

-- Business Problem: The company has no visibility into whether poor workplace environment is contributing to attrition, making it impossible to prioritize culture  and environment improvements for retention.
-- Impact: 
		-- Low environment satisfaction employees (25.35% attrition) indicate a serious internal culture problem — company should conduct regular employee surveys to identify and address root causes.
		-- Helps company take targeted action by improving office culture, providing manager training and offering better workplace facilities to create a healthier and more engaging environment.
		-- Ignoring low environment satisfaction is a long term risk — it leads to increased attrition, damaged company reputation and decreased employee productivity across all departments.
        
-- Q12. Do employees who worked at more companies leave sooner? Show attrition rate by number of previous companies worked.
select distinct(NumCompaniesWorked) from hr_attrition;

SELECT
CASE 
	WHEN NumCompaniesWorked >=0 AND NumCompaniesWorked <= 2 THEN '0-2 COMP'
    WHEN NumCompaniesWorked > 2 AND NumCompaniesWorked <= 5 THEN '2-5 COMP'
    WHEN NumCompaniesWorked > 5 AND NumCompaniesWorked <= 7 THEN '5-7 COMP'
    ELSE '7+ COMP'
END AS TOTAL_COMP_WORKED,
COUNT(*) AS TOTAL_EMP,
SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END ) AS EMP_LEFT,
ROUND( SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END )/COUNT(*)*100,2) AS Attrition_Rate
FROM hr_attrition
GROUP BY TOTAL_COMP_WORKED
ORDER BY Attrition_Rate DESC;

-- Business Problem: The company cannot identify whether employees with a history of frequent company changes are more likely to leave, making it impossible to assess job hopping tendency during hiring decisions.
-- Impact: 
		-- Enables HR to be more attentive during hiring by considering job hopping history as a risk factor, helping predict potential early attrition before it happens.
		-- Employees who worked at 7+ companies show 20% attrition rate indicating salary driven job hopping tendency — company should conduct competitive salary benchmarking for these employees immediately.
		-- Job hoppers can be retained through strong engagement strategies including recognition programs, regular salary reviews, challenging work assignments and specially designed loyalty programs that reward long term commitment.

-- Q13. Which business travel frequency has the highest attrition rate? Show attrition rate by travel frequency.

SELECT BusinessTravel,
COUNT(*) AS TOTAL_EMP,
SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END ) AS EMP_LEFT,
ROUND( SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END )/COUNT(*)*100,2) AS Attrition_Rate
FROM hr_attrition
GROUP BY BusinessTravel
ORDER BY Attrition_Rate DESC;

-- Business Problem: The company has no visibility into whether frequent business travel is contributing to employee burnout and attrition, making it impossible to design a fair and balanced travel policy.

-- Impact:
      -- Frequently travelling employees (24.91% attrition) are 3x more likely to leave than non-travelling employees — company should immediately review travel frequency and distribution across teams.
      -- Helps HR design travel compensation and benefits like travel allowances, extra leaves and flexibility to reduce burnout among frequently travelling employees.
      -- Enables company to set maximum travel limits per employee per year and distribute travel responsibilities more evenly across teams.
      
-- Q14 → After how many years at the company do employees leave the most?
SELECT DISTINCT(YearsAtCompany) FROM hr_attrition;

SELECT 
	CASE
		WHEN YearsAtCompany >=0 AND YearsAtCompany <= 2 THEN '0-2 YR'
		WHEN YearsAtCompany > 2 AND YearsAtCompany <= 5 THEN '2-5 YRS'
		WHEN YearsAtCompany > 5 AND YearsAtCompany <= 10 THEN '6-10 YRS'
        WHEN YearsAtCompany > 10 AND YearsAtCompany <= 20 THEN '11-20 YRS'
    ELSE '20+ YRS'
END AS TOTAL_YRS_AT_COMP,
COUNT(*) AS TOTAL_EMP,
SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END ) AS EMP_LEFT,
ROUND( SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END )/COUNT(*)*100,2) AS Attrition_Rate
FROM hr_attrition
GROUP BY TOTAL_YRS_AT_COMP
ORDER BY Attrition_Rate DESC;

-- Business Problem: The company cannot identify at which stage of an employee's tenure attrition risk is highest, making it impossible to design timely intervention programs for at risk employees.

-- Impact:
      -- New employees (0-2 years) with 29.82% attrition indicate a weak onboarding experience — company must strengthen its onboarding and early career support programs immediately.
      -- Helps HR identify critical tenure milestones where employees are most vulnerable to leaving and design targeted engagement programs for each stage.
      -- Employees who cross 10+ years show very low attrition company should focus on getting employees past the critical 2 year mark through mentorship and growth opportunities.
      
-- Q15. Does having a different manager frequently lead to attrition?      

SELECT DISTINCT YearsWithCurrManager FROM hr_attrition;

SELECT 
	CASE
		WHEN YearsWithCurrManager >=0 AND YearsWithCurrManager <= 1 THEN '0-1 YR'
        WHEN YearsWithCurrManager >=2 AND YearsWithCurrManager <= 3 THEN '2-3 YRS'
		WHEN YearsWithCurrManager >=4 AND YearsWithCurrManager <= 7 THEN '4-7 YRS'
    ELSE '8+ YRS'
END AS TOTAL_YWCM,
COUNT(*) AS TOTAL_EMP,
SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END ) AS EMP_LEFT,
ROUND( SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END )/COUNT(*)*100,2) AS Attrition_Rate
FROM hr_attrition
GROUP BY TOTAL_YWCM
ORDER BY Attrition_Rate DESC;

-- Business Problem: The company cannot determine whether frequent manager changes are contributing to attrition, making it impossible to evaluate the impact of manager stability on employee retention.

-- Impact:
      -- Employees with new managers (0-1 year) show 28.32% attrition — indicating manager transitions are a critical risk period requiring immediate support and structured handover processes.
      -- Helps company invest in manager training and relationship building programs to strengthen employee manager bonds during early transition periods.
      -- Longer manager relationships (8+ years) show only 8.12% attrition — proving that manager stability is a strong retention driver and should be prioritized in organizational structure.
      
-- Q16 → What is the overall attrition rate and how many employees left?

SELECT 
COUNT(*) AS TOTAL_EMP,
SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END) AS TOTAL_EMP_LEFT,
ROUND( SUM(CASE WHEN Attrition = 'YES' THEN 1 ELSE 0 END )/COUNT(*)*100,2) AS Attrition_Rate

FROM hr_attrition;

-- Business Problem: The company has no single consolidated view of its overall attrition health, making it impossible to benchmark performance against industry standards or track improvement over time.

-- Impact:
      -- Establishes 16.12% as the baseline attrition rate which is significantly above the healthy industry benchmark of 10% — creating urgency for immediate retention action.
      -- Enables leadership to set measurable retention targets and track progress quarter over quarter against this baseline metric.
      -- Provides a single source of truth for board level reporting and helps justify investment in employee retention programs and initiatives.

