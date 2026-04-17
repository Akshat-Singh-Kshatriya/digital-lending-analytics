CREATE TABLE loans (
    loan_amnt NUMERIC,
    term NUMERIC,
    int_rate NUMERIC,
    emp_length NUMERIC,
    annual_inc NUMERIC,
    dti NUMERIC,
    grade_B BOOLEAN,
    grade_C BOOLEAN
);

copy loans FROM 'D:\akshat\Downloads\clean_lending_data.csv' DELIMITER ',' CSV HEADER;