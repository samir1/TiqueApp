class CodesController < ApplicationController
  before_action :set_code, only: [:show, :edit, :update, :destroy]

  # GET /codes
  # GET /codes.json
  def index
    @codes = Code.all
  end

  # GET /codes/1
  # GET /codes/1.json
  def show
  end

  # GET /codes/new
  def new
    @code = Code.new
  end

  # GET /codes/1/edit
  def edit
  end

  # POST /codes
  # POST /codes.json
  def create

    @code = Code.new(code_params)
    @code.ta_emails = params[:ta_emails]

    respond_to do |format|
      if @code.save

        # find and update user with email specified by TA email list
        if !@code.ta_emails.nil?
          eval(@code.ta_emails).each do |ta_email|
            user = User.find_by(email: ta_email)
            if !user.nil?
              instructor_stu = InstructorStudentLookup.find_by(code_value: @code.code_value, student_id: user.id)
              if instructor_stu.nil?
                instructor_stu = InstructorStudentLookup.new
                instructor_stu.code_value = @code.code_value
                instructor_stu.student_id = user.id
                instructor_stu.isTA = true
                instructor_stu.save
              end
            end
          end
        end

        format.html { redirect_to '/get_tiqued', notice: 'Code was successfully created.' }
        format.json { render :show, status: :created, location: @code }
      else
        format.html { render :new }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # post /edit_ta_emails
  def edit_ta_emails
    @code_item = Code.find(params[:code_id])
  end

  # post /update_ta_emails
  def update_ta_emails

    # update ta_emails
    code = Code.find_by(owner: params[:owner], code_value: params[:code_value])

    if params[:ta_emails]
      code.ta_emails = params[:ta_emails].uniq.reject { |c| c.empty? }
    else
      code.ta_emails = nil
    end

    respond_to do |format|
      if code.save

        # remove deleted TAs from Code and InstructorStudentLookup
        students_in_class = InstructorStudentLookup.where(code_value: code.code_value, isTA: true)
        puts students_in_class.inspect
        students_in_class.each do |student_lookup|
          user = User.find(student_lookup.student_id)
          if user
            if (!code.ta_emails) or (code.ta_emails and !code.ta_emails.include? user.email)
              student_lookup.isTA = false
              student_lookup.save
            end
          end
        end


        # find and update user with email specified by TA email list
        if !code.ta_emails.nil?
          eval(code.ta_emails).each do |ta_email|
            if ta_email.length > 1
              user = User.find_by(email: ta_email)
              if user
                instructor_stu = InstructorStudentLookup.find_by(code_value: code.code_value, student_id: user.id)
                if instructor_stu.nil?
                  instructor_stu = InstructorStudentLookup.new
                  instructor_stu.code_value = code.code_value
                  instructor_stu.student_id = user.id
                  instructor_stu.isTA = true
                  instructor_stu.save
                else
                  instructor_stu.isTA = true
                  instructor_stu.save
                end
              end
            end
          end
        end
        format.html { redirect_to '/get_tiqued', notice: 'Code was successfully updated.' }
        format.json { render :show, status: :created, location: @code }
      else
        format.html { render :new }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /codes/1
  # PATCH/PUT /codes/1.json
  def update
    respond_to do |format|
      if @code.update(code_params)
        format.html { redirect_to '/get_tiqued', notice: 'Code was successfully updated.' }
        format.json { render :show, status: :ok, location: @code }
      else
        format.html { render :edit }
        format.json { render json: @code.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /codes/1
  # DELETE /codes/1.json
  def destroy
    @code.destroy
    respond_to do |format|
      format.html { redirect_to '/get_tiqued', notice: 'Code was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code
      @code = Code.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def code_params
      params.permit(:owner, :title)
    end
end
