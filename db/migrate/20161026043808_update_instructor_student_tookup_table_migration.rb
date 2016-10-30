class UpdateInstructorStudentTookupTableMigration < ActiveRecord::Migration[5.0]
  def change
    rename_column :instructor_student_lookups, :instructor_id, :code_value
    change_column :instructor_student_lookups, :code_value, :string
  end
end
