class CritiquesController < ApplicationController
  before_action :set_critique, only: [:show, :edit, :update, :destroy]

  # GET /critiques
  # GET /critiques.json
  def index
    @critiques = Critique.all
  end

  # GET /critiques/1
  # GET /critiques/1.json
  def show
  end

  # GET /critiques/new
  def new
    @critique = Critique.new
  end

  # GET /critiques/1/edit
  def edit
  end

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
  def update
    respond_to do |format|
      if @critique.update(critique_params)
        format.html { redirect_to @critique, notice: 'Critique was successfully updated.' }
        format.json { render :show, status: :ok, location: @critique }
      else
        format.html { render :edit }
        format.json { render json: @critique.errors, status: :unprocessable_entity }
      end
    end
  end

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
    @critiques = Critique.where(receiver_id: current_user.id).order(created_at: :desc)
    @plus_critiques = Critique.where(receiver_id: current_user.id, positive: true)
    @neg_critiques = Critique.where(receiver_id: current_user.id, positive: false)
  end

  def give_feedback
    receiver = User.find_by(user_code: params[:instructor_code])
    if !logged_in?
      redirect_to '/'
    elsif !receiver
      redirect_to '/viewinstructors'
    elsif !(InstructorStudentLookup.find_by(instructor_id: receiver.id, student_id: current_user.id))
      redirect_to '/viewinstructors'
    else
      @critiques = Critique.where(receiver_id: receiver.id).order(created_at: :desc)
      @plus_critiques = Critique.where(receiver_id: receiver.id, positive: true)
      @neg_critiques = Critique.where(receiver_id: receiver.id, positive: false)
    end
  end

  def submit_feedback
    receiver = User.find_by(user_code: params[:instructor_code])
    pos = params[:negative] ? false : true
    @critique = Critique.new(author_id: current_user.id, receiver_id: receiver.id, comment: params[:comment], positive: pos)
    @critique.save
    redirect_to "/give_feedback/#{params[:instructor_code]}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_critique
      @critique = Critique.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def critique_params
      params.require(:critique).permit(:comment, :author_id, :receiver_id, :positive)
    end
end
