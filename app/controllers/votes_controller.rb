class VotesController < ApplicationController

    def create
        if !logged_in?
            redirect_to '/'
        end

        existing_vote = Vote.find_by(voter_id: current_user.id, critique_id: params[:critique_id])
        if !existing_vote
            vote = Vote.new(voter_id: current_user.id, critique_id: params[:critique_id], upvote: params[:upvote])
            vote.save
        else
            Vote.destroy_all(voter_id: current_user.id, critique_id: params[:critique_id])
        end

        redirect_to "/give_feedback/#{params[:instructor_code]}"
    end

end