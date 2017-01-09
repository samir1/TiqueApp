require 'securerandom'

class Code < ApplicationRecord

    before_create :randomize_user_code, :generate_code_id
    validates :owner, presence: true
    validates :title, presence: true
    belongs_to :user, :foreign_key => :owner

    private
    def randomize_user_code
        begin
            self.code_value = (0...4).map { ('a'..'z').to_a[rand(26)] }.join
        end while Code.where(id: self.id).exists?
    end

    def generate_code_id
        begin
            self.code_id = SecureRandom.uuid
        end while Code.where(id: self.id).exists?
    end

end
