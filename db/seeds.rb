# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

stu = User.create(fname: 'Student', lname: 'Student', email: 'test1@test.com', password_digest: 'samir123', password_digest_confirmation: 'samir123')
stu.save!

inst = User.create(fname: 'Instructor', lname: 'Instructor', email: 'test2@test.com', password_digest: 'samir123', password_digest_confirmation: 'samir123')
inst.save!

samir = User.create(fname: 'Samir', lname: 'Undavia', email: 'samir@test.com', password_digest: 'samir123', password_digest_confirmation: 'samir123')
samir.save!

instStu = InstructorStudentLookup.create(instructor_id: 2, student_id: 1)
instStu.save!

# cri = Critique.create(comment: 'tique comment 1 from Student to Instructor', author_id: 1, receiver_id:2)
# cri.save!