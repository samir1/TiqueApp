require 'obscenity/active_model'

class Critique < ApplicationRecord
    validates :comment, obscenity: true
end
