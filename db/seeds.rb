# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admins
 u = User.new(name: 'Admin', email: 'admin@gmail.com', password: 'hi123456', role: 'Admin')
 u.save!

# schools 

 s1 = School.new(name: 'School 1', address: 'Test 1')
 s1.save!

 s2 = School.new(name: 'School 2', address: 'Test 1')
 s2.save!

# School Admins
 u = SchoolAdmin.new(name: 'School Admin1', email: 'school_admin1@gmail.com', password: 'hi123456', role: 'School Admin', school: s1)
 u.save!

 u = SchoolAdmin.new(name: 'School Admin2', email: 'school_admin2@gmail.com', password: 'hi123456', role: 'School Admin', school: s1)
 u.save!

 u = SchoolAdmin.new(name: 'School Admin3', email: 'school_admin3@gmail.com', password: 'hi123456', role: 'School Admin', school: s2)
 u.save!

 u = SchoolAdmin.new(name: 'School Admin4', email: 'school_admin4@gmail.com', password: 'hi123456', role: 'School Admin', school: s2)
 u.save!

# Students

 su1 = Student.new(name: 'Student 1', email: 'student1@gmail.com', password: 'hi123456', role: 'Student', school: s1)
 su1.save!

 su2 = Student.new(name: 'Student 2', email: 'student2@gmail.com', password: 'hi123456', role: 'Student', school: s1)
 su2.save!

 su3= Student.new(name: 'Student 1', email: 'student3@gmail.com', password: 'hi123456', role: 'Student', school: s2)
 su3.save!

 su4= Student.new(name: 'Student 2', email: 'student4@gmail.com', password: 'hi123456', role: 'Student', school: s2)
 su4.save!


 # Course

 c = Course.new(name: 'Course 1', description: 'Course', school: s1)
 c.save!

 c = Course.new(name: 'Course 2', description: 'Course', school: s1)
 c.save!

 c = Course.new(name: 'Course 1', description: 'Course', school: s2)
 c.save!

 c = Course.new(name: 'Course 2', description: 'Course', school: s2)
 c.save!



# Batch

 b1 = Batch.new(name: 'Batch 1', start_date: '2023-3-12', end_date: '2023-3-29', school: s1)
 b1.save!

 b2 = Batch.new(name: 'Batch 2', start_date: '2023-3-12', end_date: '2023-3-29', school: s1)
 b2.save!

 b3= Batch.new(name: 'Batch 1', start_date: '2023-3-12', end_date: '2023-3-29', school: s2)
 b3.save!

 b4 = Batch.new(name: 'Batch 2', start_date: '2023-3-12', end_date: '2023-3-29', school: s2)
 b4.save!


 # Enrollments

 e1 = Enrollment.new(batch: b1, student: su1, status: :active)
 e1.save!

 e2 = Enrollment.new(batch: b1, student: su2, status: :pending)
 e2.save!

 e3 = Enrollment.new(batch: b3, student: su3, status: :active)
 e3.save!