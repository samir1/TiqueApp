class InstructorStudentLookupsController < ApplicationController

    def new
    end

    def create
        if !current_user
            redirect_to '/'
        end

        code = Code.find_by(code_value: params[:instructor_code].downcase)

        if !code
            render html: "<script>alert('Invalid code');window.location = '/addinstructor';</script>".html_safe
        elsif InstructorStudentLookup.find_by(code_value: code.code_value, student_id: current_user.id)
            render html: "<script>alert('You have already entered this code');window.location = '/addinstructor';</script>".html_safe
        else 
            inst_stu = InstructorStudentLookup.new
            inst_stu.code_value = code.code_value
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
