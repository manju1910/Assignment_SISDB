 # Task 3. Aggregate functions, Having, Order By, GroupBy and Joins:



## 1. Write an SQL query to calculate the total payments made by a specific student. You will need to join the "Payments" table with the "Students" table based on the student's ID.
```sql    
select sum(amount) as Total_Payment,p.student_id from Payments p inner join Students s on p.student_id=s.student_id group by p.student_id having p.student_id=4;
```
## 2. Write an SQL query to retrieve a list of courses along with the count of students enrolled in each course.Use a JOIN operation between the "Courses" table and the "Enrollments" table.
```sql
 select count(student_id) as students_enrolled,c.course_name from Courses c inner join Enrollments e on c.course_id=e.course_id group by course_name
```
 ## 3. Write an SQL query to find the names of students who have not enrolled in any course. Use a LEFT JOIN between the "Students" table and the "Enrollments" table to identify students without enrollments.
```sql
  select distinct s.first_name,s.last_name from  Students s left join  Enrollments e on s.student_id = e.student_id where e.student_id IS NULL;
```
## 4. Write an SQL query to retrieve the first name, last name of students, and the names of the courses they are enrolled in. Use JOIN operations between the "Students" table and the "Enrollments" and "Courses" tables.
 ```sql
  select s.first_name,s.last_name,c.course_name from Students s inner join Enrollments e on s.student_id = e.student_id inner join
  Courses c on e.course_id = c.course_id;
```
## 5. Create a query to list the names of teachers and the courses they are assigned to. Join the "Teacher" table with the "Courses" table.
```sql
  select first_name,last_name,course_name from teacher t inner join courses c on t.teacher_id=c.teacher_id;
```
## 6. Retrieve a list of students and their enrollment dates for a specific course. You'll need to join the "Students" table with the "Enrollments" and "Courses" tables.
```sql
  select S.first_name,S.last_name,e.enrollment_date from Students s inner join Enrollments e on s.student_id= e.student_id
  inner join Courses c on e.course_id=c.course_id where c.course_name='IT';
```
## 7. Find the names of students who have not made any payments. Use a LEFT JOIN between the "Students" table and the "Payments" table and filter for students with NULL payment records.
```sql
  select first_name,last_name from Students s left join Payments p on s.student_id=p.student_id where p.amount is null;
```
## 8. Write a query to identify courses that have no enrollments. You'll need to use a LEFT JOIN between the "Courses" table and the "Enrollments" table and filter for courses with NULL enrollment records.
```sql
  select course_name from courses  c left join Enrollments e  on  c.course_id=e.course_id where e.enrollment_id is null;
```
## 9. Identify students who are enrolled in more than one course. Use a self-join on the "Enrollments" table to find students with multiple enrollment records.
```sql
   select count(course_id),student_id from Enrollments group by student_id having count(course_id)>1
   --or
  select a.student_id from Enrollments a join Enrollments b on a.student_id=b.student_id group by a.student_id having count(a.enrollment_id)>1
```
## 10. Find teachers who are not assigned to any courses. Use a LEFT JOIN between the "Teacher" table and the "Courses" table and filter for teachers with NULL course assignments.
```sql
select  t.teacher_id, t.first_name, t.last_name from Teacher t left join  Courses c on t.teacher_id = c.teacher_id where  c.teacher_id is null;
```