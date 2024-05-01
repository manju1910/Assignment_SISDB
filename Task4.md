# Task 4. Subquery and its type:


## 1. Write an SQL query to calculate the average number of students enrolled in each course. Use aggregate functions and subqueries to achieve this.
```sql
select course_id,avg(num_students) as average from  (select course_id,count(*) as num_students from 
  Enrollments group by  course_id ) as student_counts group by course_id; 
 ``` 
## 2. Identify the student(s) who made the highest payment. Use a subquery to find the maximum payment amount and then retrieve the student(s) associated with that amount.
```sql
 select student_id,first_name ,last_name from students where student_id in( select student_id from Payments where amount in (select max(amount) from Payments)  )
```

## 3. Retrieve a list of courses with the highest number of enrollments. Use subqueries to find the course(s) with the maximum enrollment count.
```sql                         
select c.course_id, c.course_name, count(*) as enrollment_count from Courses c join Enrollments e on c.course_id =e.course_id group by c.course_id, c.course_name having count(*) = (select max(enrollment_count) from (select count(*)
as enrollment_count from Enrollments group by course_id) as max_enrollment)
```						  
## 4. Calculate the total payments made to courses taught by each teacher. Use subqueries to sum payments for each teacher's courses	
```sql               
select teacher_id, first_name, last_name, (select sum(amount) from Payments where student_id IN (select student_id from 
		Enrollments where course_id IN (select course_id from Courses where teacher_id = t.teacher_id))) as total_payments from Teacher t;
```
## 5. Identify students who are enrolled in all available courses. Use subqueries to compare a student's enrollments with the total number of courses.

```sql
  SELECT student_id,first_name,last_name FROM  Students WHERE (SELECT COUNT(DISTINCT course_id) FROM Courses) = (SELECT COUNT(DISTINCT course_id)
  FROM Enrollments WHERE Enrollments.student_id = Students.student_id);
```
## 6. Retrieve the names of teachers who have not been assigned to any courses. Use subqueries to find teachers with no course assignments.
```sql
 select first_name,last_name from teacher where teacher_id not in(select teacher_id from Courses)
```
## 7. Calculate the average age of all students. Use subqueries to calculate the age of each student based on their date of birth.

```sql 
select avg(age) as average_age from (select 2024 - cast(substring(date_of_birth, 1, 4) as int) as age from Students) as student_age;
```
	   
## 8. Identify courses with no enrollments. Use subqueries to find courses without enrollment records.
```sql
  select course_name from Courses where course_id not in (select course_id from Enrollments)
```
 ## 9. Calculate the total payments made by each student for each course they are enrolled in. Use subqueries and aggregate functions to sum payments.
```sql
select student_id,  course_id, ( select sum(amount) from Payments where Payments.student_id = Enrollments.student_id ) as total_payments from Enrollments;
```
## 10. Identify students who have made more than one payment. Use subqueries and aggregate functions to count payments per student and filter for those with counts greater than one.
  
  ```sql
  select first_name,last_name,student_id from Students where student_id in ( select student_id from payments group by student_id having count(payment_id)>1 ) 
 ```

## 11. Write an SQL query to calculate the total payments made by each student. Join the "Students" table with the "Payments"table and use GROUP BY to calculate the sum of payments for each student.
 ```sql 
  select s.first_name,s.last_name,sum(p.amount) from Students s  join Payments p on  s.student_id=p.student_id  group by s.student_id,s.first_name,s.last_name
 ``` 
## 12. Retrieve a list of course names along with the count of students enrolled in each course. Use JOIN operations between the "Courses" table and the "Enrollments" table and GROUP BY to count enrollments.
```sql
select course_name,count(e.course_id) as total_count from Courses c inner join Enrollments e on c.course_id=e.course_id group by c.course_id,c.course_name
```
## 13. Calculate the average payment amount made by students. Use JOIN operations between the "Students" table and the "Payments" table and GROUP BY to calculate the average.
```sql
 select first_name,last_name,avg(p.amount) from Students s inner join Payments p on s.student_id=p.student_id group by s.student_id,s.first_name,s.last_name
```