SELECT * FROM bank_loan_data;

--Key Performance Indicators (KPIs) Requirements:

--Total Loan Applications 

SELECT COUNT(id) AS 'Total Loan Applications' From bank_loan_data;

--Total Funded Amount

SELECT SUM(loan_amount) AS 'Total Funded Amount' FROM bank_loan_data;

--SELECT SUM(loan_amount) AS 'MTD Total Funded Amount' FROM bank_loan_data
--WHERE MONTH(issue_date) = 12;

--Total Amount Received

SELECT SUM(total_payment) AS 'Total Amount Received' FROM bank_loan_data;

--Interest Received 

SELECT SUM(total_payment) - SUM(loan_amount) AS 'TOTAL INTEREST' FROM bank_loan_data;


--Average Interest Rate

SELECT ROUND(AVG(int_rate), 4) * 100 AS 'Average Interest Rate' FROM bank_loan_data;

SELECT ROUND(AVG(int_rate),4) * 100 AS 'Average Interest Rate' FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

--Average Debt-to-Income Ratio (DTI)

SELECT ROUND(AVG(dti) , 4) * 100 AS 'Avg DTI' FROM bank_loan_data;


SELECT ROUND(AVG(dti) , 4) * 100 AS 'Avg DTI' FROM bank_loan_data
WHERE MONTH(issue_date) = 12;

SELECT ROUND(AVG(dti) , 4) * 100 AS 'Avg DTI' FROM bank_loan_data
WHERE MONTH(issue_date) = 11;

--GOOD LOAN KPIs:

--Good Loan Application Percentage:

SELECT 
	(COUNT(CASE WHEN Loan_Status = 'Fully Paid' OR Loan_Status = 'Current' THEN id END) * 100) 
	/ COUNT(id) As ' Good Loan Percentage' 
	FROM Bank_loan_data;

--Good Loan Applications

SELECT COUNT(id) AS 'Good Loan Applications' FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

--Good Loan Funded Amount

SELECT SUM(loan_amount) AS 'Good Loan Funded Amount' FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

--Good Loan Total Received Amount:

SELECT SUM(total_payment) AS 'Good Loan Total Amount Received' FROM bank_loan_data
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

--BAD LOAN KPIs:

--Bad Loan Application Percentage:

SELECT 
	(COUNT(CASE WHEN Loan_Status = 'Charged Off' THEN id END) * 100.0) 
	/ COUNT(id) As ' Bad Loan Percentage' 
	FROM Bank_loan_data;

--Bad Loan Applications:

SELECT COUNT(id) AS 'Bad Loan Applications' FROM bank_loan_data
WHERE loan_status = 'Charged Off';

--Bad Loan Funded Amount:

SELECT SUM(loan_amount) AS 'Bad Loan Funded Amount' FROM bank_loan_data
WHERE loan_status = 'Charged Off';

--Bad Loan Total Received Amount:

SELECT SUM(total_payment) AS 'Bad Loan Funded Amount' FROM bank_loan_data
WHERE loan_status = 'Charged Off';

---LOAN STATUS GRID VIEW

-- 'Total Loan Applications,' 'Total Funded Amount,' 'Total Amount Received,'
-- 'Average Interest Rate,' and 'Average Debt-to-Income Ratio (DTI),'

SELECT Loan_status,
	COUNT(id) AS 'Total Loan Applications',
	SUM(loan_amount) AS 'Total Funded Amount',
	SUM(total_payment) AS 'Total Amount Received',
	AVG(int_rate) * 100 AS 'Avg interest Rate',
	AVG(dti) * 100 AS 'Avg DTI'
	FROM bank_loan_data
	GROUP BY loan_status;

--CHART REQUIREMENT

--1.Monthly Trends by Issue Date

/*This chart will showcase how 'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received' 
vary over time, allowing us to identify seasonality and long-term trends in lending activities. */

SELECT 
	MONTH(issue_date) AS 'Month Number',
	DATENAME(MONTH, issue_date) AS 'MONTH NAME',
	COUNT(id) AS 'Total Loan Applications',
	SUM(loan_amount) AS 'Total Funded Amount',
	SUM(total_payment) AS 'Total Amount Received'
	FROM bank_loan_data
	GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date) 
	ORDER BY MONTH(issue_date) ASC;

--2. Regional Analysis by State

/* This  will visually represent lending metrics categorized by state, 
enabling us to identify regions with significant lending activity and assess regional disparities.
'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'. */

SELECT address_state AS 'State',
	COUNT(id) AS 'Total Loan Applications',
	SUM(loan_amount) AS 'Total Funded Amount',
	SUM(total_payment) AS 'Total Amount Received'
	FROM bank_loan_data
	GROUP BY address_state
	ORDER BY COUNT(id) DESC;

--4.Loan Term Analysis 
--'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'
/*This chart will depict loan statistics based on different loan terms, 
allowing us to understand the distribution of loans across various term lengths.*/

SELECT term, 
		COUNT(id) AS 'Total Loan Applications',
		SUM(loan_amount) AS 'Total Funded Amount',
		SUM(total_payment) AS 'Total Amount Received'
		FROM bank_loan_data
		GROUP BY term;

--4. Employee Length Analysis
/*  This  chart will illustrate how lending metrics are distributed among borrowers with different employment lengths,
helping us assess the impact of employment history on loan applications. */

SELECT emp_length,
		COUNT(id) AS 'Total Loan Applications',
		SUM(loan_amount) AS 'Total Funded Amount',
		SUM(total_payment) AS 'Total Amount Received'
	FROM bank_loan_data
	GROUP BY emp_length
	ORDER BY emp_length;

--5. Loan Purpose Breakdown 

/* This bar chart will provide a visual breakdown of loan metrics based on the stated purposes of loans,
aiding in the understanding of the primary reasons borrowers seek financing.*/

SELECT purpose,
	COUNT(id) AS 'Total Loan Applications',
			SUM(loan_amount) AS 'Total Funded Amount',
			SUM(total_payment) AS 'Total Amount Received'
		FROM bank_loan_data
		GROUP BY purpose
		ORDER BY 'Total Loan Applications' DESC;

--6. Home Ownership Analysis 

/*  This tree map will display loan metrics categorized by different home ownership statuses, 
allowing for a hierarchical view of how home ownership impacts loan applications and disbursements. */


SELECT home_ownership,
	COUNT(id) AS 'Total Loan Applications',
			SUM(loan_amount) AS 'Total Funded Amount',
			SUM(total_payment) AS 'Total Amount Received'
		FROM bank_loan_data
		GROUP BY home_ownership
		ORDER BY 'Total Loan Applications' DESC;
		
