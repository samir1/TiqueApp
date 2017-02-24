module CritiquesHelper

	include CodesHelper

    def get_votes_for_critique_id critique_id
        Vote.where(critique_id: critique_id, upvote: true).count - Vote.where(critique_id: critique_id, upvote: false).count
    end

    def get_vote_for_critique_id critique_id
        vote = Vote.find_by(voter_id: current_user.id, critique_id: critique_id)
    end

end
