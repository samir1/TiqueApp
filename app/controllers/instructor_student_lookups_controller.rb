class InstructorStudentLookupsController < ApplicationController

    def new
    end

    def create
        inst = User.find_by(user_code: params[:instructor_code].downcase)
        existing_record = 
        if !inst || !current_user
            render html: "<script>alert('Invalid code');window.location = '/addinstructor';</script>".html_safe
        elsif InstructorStudentLookup.find_by(instructor_id: inst.id, student_id: current_user.id)
            render html: "<script>alert('You have already entered this code');window.location = '/addinstructor';</script>".html_safe
        else 
            inst_stu = InstructorStudentLookup.new
            inst_stu.instructor_id = inst.id
            inst_stu.student_id = current_user.id

            if inst_stu.save
                redirect_to '/viewinstructors'
            else
                format.html { render :new }
                format.json { render json: inst_stu.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
    end
end
