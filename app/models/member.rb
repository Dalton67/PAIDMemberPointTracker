class Member < ApplicationRecord
  has_and_belongs_to_many :events
  after_initialize :init
  require 'csv'
  def init
    self.fall_points ||= 0
    self.spring_points ||= 0
    self.total_points ||= 0
  end
  def self.import(file,points)
    CSV.foreach(file.path,headers:true) do |row|
      member = Member.find_by(email: row['email'])
      if member
        puts points
        puts "*********"
        member.update_attribute(:total_points, points)
        member.save()
      end
      #Member.create! row.to_hash
    end
  end
end
