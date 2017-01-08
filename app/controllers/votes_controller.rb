class VotesController < ApplicationController
  def create
    if !logged_in?
      redirect_to '/'
    end

    existing_vote = Vote.find_by(voter_id: current_user.id, critique_id: params[:critique_id])
    Vote.destroy_all(voter_id: current_user.id, critique_id: params[:critique_id])
    unless existing_vote && existing_vote.upvote.to_s.eql?(params[:upvote])
      @vote = Vote.new(voter_id: current_user.id, critique_id: params[:critique_id], upvote: params[:upvote])
      @vote.save
    end
    @critique = Critique.where(id: params[:critique_id]).first

    respond_to do |format|
      format.js
    end

    # redirect_to "/give_feedback/#{params[:instructor_code]}"
  end
end