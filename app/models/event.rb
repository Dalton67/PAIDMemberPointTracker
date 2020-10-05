class Event < ApplicationRecord
  has_and_belongs_to_many :members
  after_initialize :init
  def init
    self.points_worth ||= 1
  end
end
