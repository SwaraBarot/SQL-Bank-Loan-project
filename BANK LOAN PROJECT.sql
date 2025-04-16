select * from [bank_loan_data ]

--total loan application --
select count(id) from [bank_loan_data ]

--mtd loan application--
select count(id) as Mtd_application from  [bank_loan_data ]
where month(issue_date) = 12

--Pmtd loan application--
select count(id) as Mtd_application from  [bank_loan_data ]
where month(issue_date) = 11

--Total Funded Amount
SELECT SUM(Loan_amount) as total_funded_amount  from [bank_loan_data ]

--MTD Total Funded Amount
select sum(loan_amount) as mtd_tfa from [bank_loan_data ]
where month(issue_date) = 12

--PMTD Total Funded Amount
Select sum(loan_amount) as pmtd from [bank_loan_data ]
where MONTH(issue_date) = 11

--Average Interest Rate
SELECT AVG(int_rate)*100 AS Avg_Int_Rate FROM [bank_loan_data ]

--Avg DTI
SELECT AVG(dti)*100 AS Avg_DTI FROM [bank_loan_data ]

--Good Loan Percentage
select (count(
	case
	when loan_status = 'Fully Paid' or loan_status = 'Current' then id
	end)*100)/count(id) as good_loan_percent 
from [bank_loan_data ]

--Bad Loan Percentage
SELECT
    (COUNT(CASE 
	WHEN loan_status = 'Charged Off' THEN id END) * 100.0) / 
	COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data

--LOAN STATUS
	SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate * 100) AS Interest_Rate,
        AVG(dti * 100) AS DTI
    FROM
        bank_loan_data
    GROUP BY
        loan_status


		SELECT 
	loan_status, 
	SUM(total_payment) AS MTD_Total_Amount_Received, 
	SUM(loan_amount) AS MTD_Total_Funded_Amount 
FROM bank_loan_data
WHERE MONTH(issue_date) = 12 
GROUP BY loan_status


--BANK LOAN REPORT | OVERVIEW
MONTH
SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)
