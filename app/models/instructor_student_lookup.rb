class InstructorStudentLookup < ApplicationRecord
    validates_uniqueness_of   :student_id, scope: :instructor_id
end
