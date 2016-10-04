class Critique < ApplicationRecord
  after_initialize :default_values

  private
    def default_values
      self.votes ||= 0
    end
end
