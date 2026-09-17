
SELECT *
FROM credit_risk
LIMIT 10;

SELECT COUNT(*) AS total_loans
FROM credit_risk;

SELECT
    COUNT(*) AS total_loans,
    SUM(loan_status) AS total_defaults,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_percentage
FROM credit_risk;

SELECT
    loan_grade,
    COUNT(*) AS total_loans,
    SUM(loan_status) AS defaults,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_percentage
FROM credit_risk
GROUP BY loan_grade
ORDER BY default_rate_percentage DESC;

SELECT
    loan_intent,
    COUNT(*) AS total_loans,
    SUM(loan_status) AS defaults,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_percentage
FROM credit_risk
GROUP BY loan_intent
ORDER BY default_rate_percentage DESC;

SELECT
    person_home_ownership,
    COUNT(*) AS total_loans,
    SUM(loan_status) AS defaults,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_percentage
FROM credit_risk
GROUP BY person_home_ownership
ORDER BY default_rate_percentage DESC;

SELECT
    cb_person_default_on_file,
    COUNT(*) AS total_loans,
    SUM(loan_status) AS defaults,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_percentage
FROM credit_risk
GROUP BY cb_person_default_on_file
ORDER BY default_rate_percentage DESC;

SELECT
    CASE
        WHEN loan_percent_income < 0.10 THEN 'Low Burden'
        WHEN loan_percent_income < 0.20 THEN 'Moderate Burden'
        WHEN loan_percent_income < 0.30 THEN 'High Burden'
        ELSE 'Very High Burden'
    END AS income_burden,
    COUNT(*) AS total_loans,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate_percentage
FROM credit_risk
GROUP BY income_burden
ORDER BY default_rate_percentage DESC;

WITH grade_analysis AS (
    SELECT
        loan_grade,
        COUNT(*) AS total_loans,
        SUM(loan_status) AS defaults,
        AVG(loan_status) * 100 AS default_rate
    FROM credit_risk
    GROUP BY loan_grade
)
SELECT
    loan_grade,
    total_loans,
    defaults,
    ROUND(default_rate, 2) AS default_rate_percentage
FROM grade_analysis
ORDER BY default_rate DESC;

SELECT
    person_age,
    person_income,
    loan_amnt,
    loan_int_rate,
    loan_status
FROM credit_risk
WHERE loan_amnt > (
    SELECT AVG(loan_amnt)
    FROM credit_risk
)
ORDER BY loan_amnt DESC;

WITH grade_rates AS (
    SELECT
        loan_grade,
        AVG(loan_status) * 100 AS default_rate
    FROM credit_risk
    GROUP BY loan_grade
)
SELECT
    loan_grade,
    ROUND(default_rate, 2) AS default_rate_percentage,
    RANK() OVER (
        ORDER BY default_rate DESC
    ) AS risk_rank
FROM grade_rates
ORDER BY risk_rank;

SELECT
    COUNT(*) AS total_records,
    SUM(CASE WHEN person_age IS NULL THEN 1 ELSE 0 END) AS missing_age,
    SUM(CASE WHEN person_income IS NULL THEN 1 ELSE 0 END) AS missing_income,
    SUM(CASE WHEN loan_amnt IS NULL THEN 1 ELSE 0 END) AS missing_loan_amount,
    SUM(CASE WHEN loan_int_rate IS NULL THEN 1 ELSE 0 END) AS missing_interest_rate,
    SUM(CASE WHEN loan_status IS NULL THEN 1 ELSE 0 END) AS missing_loan_status
FROM credit_risk;

SELECT
    loan_grade,
    loan_intent,
    COUNT(*) AS total_loans,
    SUM(loan_status) AS defaults,
    ROUND(AVG(loan_status) * 100, 2) AS default_rate,
    ROUND(AVG(loan_amnt), 2) AS average_loan_amount,
    ROUND(AVG(loan_int_rate), 2) AS average_interest_rate
FROM credit_risk
GROUP BY
    loan_grade,
    loan_intent
ORDER BY default_rate DESC;
