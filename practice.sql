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