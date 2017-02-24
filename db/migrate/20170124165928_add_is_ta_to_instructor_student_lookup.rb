class AddIsTaToInstructorStudentLookup < ActiveRecord::Migration[5.0]
  def change
    add_column :instructor_student_lookups, :isTA, :boolean, default: false
  end
end
