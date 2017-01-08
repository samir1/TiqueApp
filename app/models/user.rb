class User < ApplicationRecord
	attr_accessor :password_digest_confirmation
    before_save { self.email = email.downcase }
    validates :password_digest, confirmation: true
    validates :password_digest_confirmation, presence: true
    validates :fname, presence: true, length: { maximum: 50 }
    validates :lname, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
    has_secure_password
    validates :password_digest, presence: true, length: { minimum: 6 }
    before_save :encrypt_password

    has_many :codes, :foreign_key => :owner, :dependent => :destroy

    private
    def encrypt_password
        self.salt = BCrypt::Engine.generate_salt
        self.password_digest = BCrypt::Engine.hash_secret(self.password_digest, self.salt)
    end
end
