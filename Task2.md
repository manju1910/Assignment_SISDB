# Tasks 2: Select, Where, Between, AND, LIKE: 

## 1. Write an SQL query to insert a new student into the "Students" table with the following details:
a. First Name: John
b. Last Name: Doe
				c. Date of Birth: 1995-08-15
									d. Email: john.doe@example.com
										e. Phone Number: 1234567890
 ```sql                                       
 insert into Students values(11,'John','Doe','1995-08-15','john.doe@example.com','1234567890');
```
 ## 2. Write an SQL query to enroll a student in a course. Choose an existing student and course and insert a record into the "Enrollments" table with the enrollment date.Choose an existing student_id and course_id, and specify the enrollment_date
 ```sql
  insert into Enrollments values(11,1, 3, '2023-04-27');
```

## 3. Update the email address of a specific teacher in the "Teacher" table. Choose any teacher and modify their email address.
```sql 
update Teacher set email='surya.kumar11@example.com' where first_name='Surya' and last_name='Kumar';
```	
	
## 4. Write an SQL query to delete a specific enrollment record from the "Enrollments" table. Select an enrollment record based on the student and course.
```sql
 delete from enrollments where student_id=8 and course_id=6;
 ```

 ## 5. Update the "Courses" table to assign a specific teacher to a course. Choose any course and teacher from the respective tables.
 ```sql
 update courses set course_name='BCOM' where teacher_id=1
 ```
 ## 6. Delete a specific student from the "Students" table and remove all their enrollment records from the "Enrollments" table. Be sure to maintain referential integrity.
```sql
 delete from payments where student_id=2;
 delete from Enrollments where student_id=2;
 delete from Students where student_id=2;
```
 ## 7. Update the payment amount for a specific payment record in the "Payments" table. Choose any payment record and modify the payment amount.
 ```sql
 update Payments set amount=11000 where payment_id=1;
```