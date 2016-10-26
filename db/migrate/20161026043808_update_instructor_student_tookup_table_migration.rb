class UpdateInstructorStudentTookupTableMigration < ActiveRecord::Migration[5.0]
  def change
    rename_column :instructor_student_lookups, :instructor_id, :class_code
    change_column :instructor_student_lookups, :class_code, :string
  end
end
