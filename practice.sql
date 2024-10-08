# Show first name, last name, and gender of patients whose gender is 'M'
SELECT first_name,last_name,gender FROM patients WHERE gender = 'M';


# Show first name and last name of patients who does not have allergies. (null)
SELECT first_name,last_name FROM patients WHERE allergies IS NULL;

# Show first name of patients that start with the letter 'C'
SELECT first_name FROM patients WHERE first_name LIKE "C%";

# Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT first_name,last_name FROM patients WHERE weight BETWEEN 100 AND 120;

# Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'
UPDATE patients SET allergies = 'NKA' WHERE allergies is NULL;

# Show first name and last name concatinated into one column to show their full name.
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM patients;

# Show first name, last name, and the full province name of each patient.
Example: 'Ontario' instead of 'ON'
SELECT first_name, last_name, province_name FROM patients JOIN province_names ON province_names.province_id = patients.province_id;

# Show how many patients have a birth_date with 2010 as the birth year.
SELECT COUNT(*) AS patient_count FROM patients WHERE YEAR(birth_date) = 2010;

# Show the first_name, last_name, and height of the patient with the greatest height.
SELECT first_name, last_name, height FROM patients ORDER BY height DESC LIMIT 1;
 
# Show all columns for patients who have one of the following patient_ids:
1,45,534,879,1000
SELECT * FROM patients WHERE patient_id IN (1, 45, 534, 879, 1000); 

# Show the total number of admissions
SELECT COUNT(*) AS patient_id FROM admissions;

#Show all the columns from admissions where the patient was admitted and discharged on the same day.
SELECT * FROM admissions WHERE admission_date = discharge_date;

#Show the patient id and the total number of admissions for patient_id 579.
SELECT patient_id, COUNT(*) AS total_admissions FROM admissions WHERE patient_id = 579 GROUP BY patient_id;

#Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?
SELECT distinct city FROM patients where province_id = 'NS';

# Write a query to find the first_name, last name and birth date of patients who has height greater than 160 and weight greater than 70
SELECT first_name, last_name, birth_date FROM patients where height > 160 AND weight > 70;

# Write a query to find list of patients first_name, last_name, and allergies where allergies are not null and are from the city of 'Hamilton'
SELECT first_name, last_name, allergies FROM patients where allergies IS not NULL AND city = 'Hamilton';

# Show unique birth years from patients and order them by ascending.
SELECT distinct YEAR(birth_date) AS birth_year FROM patients order by birth_date ASC;

# Show unique first names from the patients table which only occurs once in the list.
For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. 
If only 1 person is named 'Leo' then include them in the output.

SELECT distinct first_name FROM patients group by first_name having count(*) = 1;

# Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
SELECT patient_id, first_name FROM patients WHERE first_name LIKE 's%' AND first_name LIKE '%s' AND LENGTH(first_name) >= 6;

# Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
Primary diagnosis is stored in the admissions table.

SELECT patients.first_name, 
patients.last_name,
patients.patient_id FROM patients JOIN admissions
ON patients.patient_id = admissions.patient_id
where admissions.diagnosis = 'Dementia';

# Display every patient's first_name.
Order the list by the length of each name and then by alphabetically.
SELECT first_name FROM patients ORDER BY LENGTH(first_name), first_name;

# Show the total amount of male patients and the total amount of female patients in the patients table.
Display the two results in the same row.
SELECT 
  (SELECT COUNT(*) FROM patients WHERE gender = 'M') AS male_count,
  (SELECT COUNT(*) FROM patients WHERE gender = 'F') AS female_count;

# Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.
SELECT  first_name, last_name, allergies FROM patients WHERE allergies = 'Penicillin' OR allergies = 'Morphine'
ORDER BY 
allergies ASC, 
first_name ASC, 
last_name ASC;

# Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
SELECT patient_id, diagnosis FROM admissions group by patient_id, diagnosis having count(*)>1;

# Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending.
SELECT city, count(*) AS total_patients FROM patients group by city order by total_patients desc, city asc;

# Show first name, last name and role of every person that is either patient or doctor.
The roles are either "Patient" or "Doctor"
SELECT first_name, last_name,'Patient' AS role FROM patients UNION ALL
SELECT first_name, last_name,'Doctor' AS role FROM doctors;

# Show all allergies ordered by popularity. Remove NULL values from query.
SELECT allergies, COUNT(*) as popularity FROM patients WHERE allergies IS NOT NULL
GROUP BY allergies ORDER BY popularity DESC;

# Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
SELECT first_name, last_name, birth_date FROM patients where birth_date BETWEEN '1970-01-01' AND '1979-12-31' 
order by birth_date asc

# We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
EX: SMITH,jane
SELECT CONCAT(UPPER(last_name),',',LOWER(first_name))as full_name FROM patients
order by first_name desc;

# Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
SELECT province_id, SUM(height) AS sum_height FROM patients
GROUP BY province_id HAVING sum_height >= 7000

# Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
SELECT max (weight) - min (weight) as weight_difference FROM patients where last_name = 'Maroni';

# Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
SELECT DAY(admission_date) AS day_of_month, COUNT(*) AS admission_count FROM admissions
GROUP BY day_of_month ORDER BY admission_count DESC;

# Show all columns for patient_id 542's most recent admission_date.
SELECT * FROM admissions WHERE patient_id = 542 ORDER BY admission_date DESC LIMIT 1;

# Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
2. attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
SELECT patient_id, attending_doctor_id, diagnosis 
FROM admissions 
WHERE (patient_id %2 !=0 AND attending_doctor_id IN (1, 5, 19))
   OR (attending_doctor_id LIKE '%2%' AND LENGTH(patient_id) = 3);

# Show first_name, last_name, and the total number of admissions attended for each doctor.
Every admission has been attended by a doctor.
SELECT first_name, last_name, COUNT(*) AS total_admissions
FROM doctors d JOIN admissions a ON d.doctor_id = a.attending_doctor_id
GROUP BY d.first_name, d.last_name;

# For each doctor, display their id, full name, and the first and last admission date they attended.
SELECT doctor_id, CONCAT(d.first_name, ' ', d.last_name) AS full_name, 
MIN(admission_date) AS first_date, MAX(admission_date) AS last_date
FROM doctors d JOIN admissions a ON d.doctor_id = a.attending_doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name;

# Display the total amount of patients for each province. Order by descending.
SELECT COUNT(patients.patient_id) AS total_patients, province_names.province_name
FROM patients
JOIN province_names ON patients.province_id = province_names.province_id
GROUP BY province_names.province_name
ORDER BY total_patients DESC;

# For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
SELECT 
    CONCAT(patients.first_name, ' ', patients.last_name) AS patient_full_name,
    admissions.diagnosis,
    CONCAT(doctors.first_name, ' ', doctors.last_name) AS doctor_full_name
FROM 
    admissions
JOIN 
    patients ON admissions.patient_id = patients.patient_id
JOIN 
    doctors ON admissions.attending_doctor_id = doctors.doctor_id;

# display the first name, last name and number of duplicate patients based on their first name and last name.

Ex: A patient with an identical name can be considered a duplicate.
SELECT first_name, last_name, COUNT(*) 
FROM patients 
GROUP BY first_name, last_name 
HAVING COUNT(*) > 1;

# Display patient's full name,
height in the units feet rounded to 1 decimal,
weight in the unit pounds rounded to 0 decimals,
birth_date,
gender non abbreviated.

Convert CM to feet by dividing by 30.48.
Convert KG to pounds by multiplying by 2.205.
SELECT 
    CONCAT(first_name, ' ', last_name) AS "Full Name",
    ROUND(height / 30.48, 1) AS "Height (ft)",
    ROUND(weight * 2.205, 0) AS "Weight (lbs)",
    birth_date AS "Birth Date",
    CASE 
        WHEN gender = 'M' THEN 'Male'
        WHEN gender = 'F' THEN 'Female'
        ELSE gender
    END AS "Gender"
FROM 
    patients;

# Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)
SELECT patient_id, first_name, last_name FROM patients WHERE patient_id NOT IN (SELECT patient_id FROM admissions);

# Show all of the patients grouped into weight groups.
Show the total amount of patients in each weight group.
Order the list by the weight group decending.

For example, if they weight 100 to 109 they are placed in the 100 weight group, 110-119 = 110 weight group, etc.
SELECT
    (weight / 10) * 10 AS weight_group,
    COUNT(*) AS total_patients
FROM
    patients
GROUP BY
    (weight / 10) * 10
ORDER BY
    weight_group DESC;
# Show patient_id, weight, height, isObese from the patients table.

Display isObese as a boolean 0 or 1.

Obese is defined as weight(kg)/(height(m)2) >= 30.

weight is in units kg.

height is in units cm.

SELECT patient_id, weight, height, CASE WHEN (weight / ((height / 100.0) * (height / 100.0))) >= 30 THEN 1
ELSE 0 END AS isObese FROM patients;

# Show patient_id, first_name, last_name, and attending doctor's specialty.
Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'

Check patients, admissions, and doctors tables for required information.

SELECT  p.patient_id, p.first_name, p.last_name, d.specialty FROM patients p JOIN admissions a ON p.patient_id = a.patient_id JOIN 
doctors d ON a.attending_doctor_id = d.doctor_id WHERE a.diagnosis = 'Epilepsy' AND d.first_name = 'Lisa';

# All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.

The password must be the following, in order:
1. patient_id
2. the numerical length of patient's last_name
3. year of patient's birth_date

SELECT DISTINCT p.patient_id, CONCAT( p.patient_id, LEN(p.last_name), YEAR(p.birth_date)) AS temp_password 
FROM patients p JOIN admissions a ON p.patient_id = a.patient_id;

# Each admission costs $50 for patients without insurance, and $10 for patients with insurance. All patients with an even patient_id have insurance.
Give each patient a 'Yes' if they have insurance, and a 'No' if they don't have insurance. Add up the admission_total cost for each has_insurance group.
SELECT CASE WHEN p.patient_id % 2 = 0 THEN 'Yes' ELSE 'No' END AS has_insurance,
SUM(CASE WHEN p.patient_id % 2 = 0 THEN 10 ELSE 50 END) AS admission_total
FROM patients p JOIN admissions a ON p.patient_id = a.patient_id GROUP BY has_insurance;

# Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name
SELECT pn.province_name FROM patients p JOIN province_names pn ON p.province_id = pn.province_id
GROUP BY pn.province_name HAVING SUM(CASE WHEN p.gender = 'M' THEN 1 ELSE 0 END) > SUM(CASE WHEN p.gender = 'F' THEN 1 ELSE 0 END);

# We are looking for a specific patient. Pull all columns for the patient who matches the following criteria:
- First_name contains an 'r' after the first two letters.
- Identifies their gender as 'F'
- Born in February, May, or December
- Their weight would be between 60kg and 80kg
- Their patient_id is an odd number
- They are from the city 'Kingston'
SELECT * FROM patients WHERE First_name LIKE '__%r%' AND Gender = 'F' AND MONTH(birth_date) IN (2, 5, 12)
AND Weight BETWEEN 60 AND 80 AND Patient_id % 2 <> 0 AND City = 'Kingston';

# Show the percent of patients that have 'M' as their gender. Round the answer to the nearest hundreth number and in percent form.
SELECT CONCAT(ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM patients)), 
2),'%') AS percent_male FROM patients WHERE gender = 'M';

# Sort the province names in ascending order in such a way that the province 'Ontario' is always on top.
SELECT province_name FROM province_names ORDER BY
CASE WHEN province_name = 'Ontario' THEN 0 ELSE 1 END, province_name ASC;

# We need a breakdown for the total amount of admissions each doctor has started each year. Show the doctor_id, doctor_full_name, specialty, year, total_admissions for that year.
SELECT
    d.doctor_id,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_full_name,
    d.specialty,
    YEAR(a.admission_date) AS year,
    COUNT(a.patient_id) AS total_admissions
FROM
    doctors d
JOIN
    admissions a ON d.doctor_id = a.attending_doctor_id
GROUP BY
    d.doctor_id,
    doctor_full_name,
    d.specialty,
    year
ORDER BY
    d.doctor_id,
    year;

# For each day display the total amount of admissions on that day. Display the amount changed from the previous date.
SELECT 
    admission_date,
    COUNT(patient_id) AS total_admissions,
    COUNT(patient_id) - LAG(COUNT(patient_id), 1) OVER (ORDER BY admission_date) AS change_from_previous_day
FROM 
    admissions
GROUP BY 
    admission_date
ORDER BY 
    admission_date;
# Show the category_name and description from the categories table sorted by category_name.
SELECT category_name, description from categories order by category_name;

#Show all the contact_name, address, city of all customers which are not from 'Germany', 'Mexico', 'Spain'
SELECT contact_name, address, city from customers where country not in ('Germany','Mexico', 'Spain');

# Show order_date, shipped_date, customer_id, Freight of all orders placed on 2018 Feb 26
SELECT order_date, shipped_date, customer_id,freight from orders where order_date = "2018-02-26";

# Show the employee_id, order_id, customer_id, required_date, shipped_date from all orders shipped later than the required date
SELECT employee_id, order_id, customer_id, required_date, shipped_date from orders 
where shipped_date > required_date;

# Show all the even numbered Order_id from the orders table
SELECT order_id from orders where order_id %2=0;

# Show the city, company_name, contact_name of all customers from cities which contains the letter 'L' in the city name, sorted by contact_name
SELECT city, company_name, contact_name from customers where city like '%L%' order by
contact_name;

# Show the company_name, contact_name, fax number of all customers that has a fax number. (not null)
SELECT company_name,contact_name, fax from customers where fax is not null;

# Show the first_name, last_name. hire_date of the most recently hired employee.
select first_name, last_name, max(hire_date) as hire_date from employees;

# Show the average unit price rounded to 2 decimal places, the total units in stock, total discontinued products from the products table.
SELECT ROUND(AVG(unit_price), 2) AS average_unit_price,
SUM(units_in_stock) AS total_units_in_stock,
SUM(CASE WHEN discontinued = 1 THEN 1 ELSE 0 END) AS total_discontinued_products
FROM products;

# Show the ProductName, CompanyName, CategoryName from the products, suppliers, and categories table
SELECT 
    p.product_name, 
    s.company_name, 
    c.category_name
FROM 
    products p
JOIN 
    suppliers s ON p.supplier_id = s.supplier_id
JOIN 
    categories c ON p.category_id = c.category_id;

# Show the category_name and the average product unit price for each category rounded to 2 decimal places.
SELECT c.category_name, 
       ROUND(AVG(p.unit_price), 2) AS average_unit_price
FROM categories c
JOIN products p ON c.category_id = p.category_id
GROUP BY c.category_name;

# Show the city, company_name, contact_name from the customers and suppliers table merged together.
Create a column which contains 'customers' or 'suppliers' depending on the table it came from.
SELECT city, company_name, contact_name, 'customers' AS source
FROM customers
UNION ALL
SELECT city, company_name, contact_name, 'suppliers' AS source
FROM suppliers;

# Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, and a column called "Shipped" that displays "On Time" if the order shipped_date is less or equal to the required_date, "Late" if the order shipped late.
Order by employee last_name, then by first_name, and then descending by number of orders.

SELECT 
    e.first_name, 
    e.last_name, 
    COUNT(o.order_id) AS num_orders,
    CASE
        WHEN o.shipped_date <= o.required_date THEN 'On Time'
        ELSE 'Late'
    END AS Shipped
FROM 
    employees e
JOIN 
    orders o ON e.employee_id = o.employee_id
GROUP BY 
    e.employee_id, e.first_name, e.last_name, Shipped
ORDER BY 
    e.last_name ASC, 
    e.first_name ASC, 
    num_orders DESC;

# Show how much money the company lost due to giving discounts each year, order the years from most recent to least recent. Round to 2 decimal places
SELECT 
    YEAR(o.order_date) AS year, 
    ROUND(SUM(p.unit_price * od.quantity * od.discount), 2) AS discount_loss
FROM 
    order_details od
JOIN 
    orders o ON od.order_id = o.order_id
JOIN 
    products p ON od.product_id = p.product_id
GROUP BY 
    YEAR(o.order_date)
ORDER BY 
    year DESC;