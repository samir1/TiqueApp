class Vote < ApplicationRecord
    after_create :update_votes_counter
    after_destroy :update_votes_counter

    private
    def update_votes_counter
        upvotes = Vote.where(critique_id: self.critique_id, upvote: true).count
        downvotes = Vote.where(critique_id: self.critique_id, upvote: false).count
        critique = Critique.find(self.critique_id)
        critique.votes = upvotes - downvotes
        critique.save!
    end
end
