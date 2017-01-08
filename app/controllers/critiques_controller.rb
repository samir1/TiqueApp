class CritiquesController < ApplicationController
  before_action :set_critique, only: [:show, :edit, :update, :destroy]

  # GET /critiques
  # GET /critiques.json
  def index
    if !current_user
      redirect_to '/'
    end

    if current_user.email == 'samir@test.com' || current_user.email == 'priyatham.ven@gmail.com'
      @critiques = Critique.all
    else
      redirect_to '/'
    end
  end

  # GET /critiques/1
  # GET /critiques/1.json
  # def show
  # end

  # GET /critiques/new
  def new
    @critique = Critique.new
  end

  # GET /critiques/1/edit
  # def edit
  # end

  # POST /critiques
  # POST /critiques.json
  def create
    @critique = Critique.new(critique_params)

    respond_to do |format|
      if @critique.save
        format.html { redirect_to @critique, notice: 'Critique was successfully created.' }
        format.json { render :show, status: :created, location: @critique }
      else
        format.html { render :new }
        format.json { render json: @critique.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /critiques/1
  # PATCH/PUT /critiques/1.json
  # def update
  #   respond_to do |format|
  #     if @critique.update(critique_params)
  #       format.html { redirect_to @critique, notice: 'Critique was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @critique }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @critique.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /critiques/1
  # DELETE /critiques/1.json
  def destroy
    @critique.destroy
    respond_to do |format|
      format.html { redirect_to critiques_url, notice: 'Critique was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def my_feedback
    if !logged_in?
      redirect_to '/'
    end
    @my_codes = Code.where(owner: current_user.id)
  end

  def my_feedback_with_code
    code = Code.find_by(code_id: params[:instructor_code])
    @critiques = Critique.where(code_value: code.code_value).order(created_at: :desc)
    @plus_critiques = Critique.where(code_value: code.code_value, positive: true)
    @neg_critiques = Critique.where(code_value: code.code_value, positive: false)
  end

  def give_feedback
    code = Code.find_by(code_id: params[:instructor_code])
    if !logged_in?
      redirect_to '/'
    elsif !code
      redirect_to '/viewinstructors'
    elsif !(InstructorStudentLookup.find_by(code_value: code.code_value, student_id: current_user.id))
      redirect_to '/viewinstructors'
    else
      @critiques = Critique.where(code_value: code.code_value).order(created_at: :desc)
      @plus_critiques = Critique.where(code_value: code.code_value, positive: true).order(votes: :desc)
      @neg_critiques = Critique.where(code_value: code.code_value, positive: false).order(votes: :desc)
    end
  end

  def refresh_pluses_minuses
    code = Code.find_by(code_id: params[:instructor_code])
    @critiques = @plus_critiques = @neg_critiques = []
    if code.present?
      @critiques = Critique.where(code_value: code.code_value).order(created_at: :desc)
      @plus_critiques = Critique.where(code_value: code.code_value, positive: true).order(votes: :desc)
      @neg_critiques = Critique.where(code_value: code.code_value, positive: false).order(votes: :desc)
    end
    respond_to do |format|
      format.js
    end
  end

  def submit_feedback
    code = Code.find_by(code_id: params[:instructor_code])
    pos = params[:negative] ? false : true
    @critique = Critique.new(author_id: current_user.id, code_value: code.code_value, comment: params[:comment], positive: pos)
    respond_to do |format|
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_critique
      @critique = Critique.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def critique_params
      params.require(:critique).permit(:comment, :author_id, :instructor_code, :positive)
    end
end
