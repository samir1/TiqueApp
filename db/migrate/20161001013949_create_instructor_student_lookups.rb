class CreateInstructorStudentLookups < ActiveRecord::Migration[5.0]
  def change
    create_table :instructor_student_lookups do |t|
      t.integer :instructor_id, foreign_key: true
      t.integer :student_id, foreign_key: true

      t.timestamps
    end
  end
end
