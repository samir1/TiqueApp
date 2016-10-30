class InstructorStudentLookup < ApplicationRecord
    validates_uniqueness_of   :student_id, scope: :code_value
end
