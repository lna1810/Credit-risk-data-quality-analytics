
CREATE OR REPLACE TABLE credit_risk (
    person_age INTEGER,
    person_income DOUBLE,
    person_home_ownership VARCHAR,
    person_emp_length DOUBLE,
    loan_intent VARCHAR,
    loan_grade VARCHAR,
    loan_amnt DOUBLE,
    loan_int_rate DOUBLE,
    loan_status INTEGER,
    loan_percent_income DOUBLE,
    cb_person_default_on_file VARCHAR,
    cb_person_cred_hist_length INTEGER
);
