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
    data = Array.new
    CSV.foreach(file.path,headers:true) do |row|
      member = Member.find_by(email: row['email'])
      if member
        puts points
        member.update_attribute(:total_points, points.to_i+member.total_points)
        member.save()
      else
        data.push(row['email'])
      end 
    end
    return data
  end

  def self.search(search)
    if search
      member_type = Member.find_by(first_name: search)
        if member_type
          self.where(member_id: member_type)
        else
          @members = Member.all
        end
      else
        @members = Member.all
      end
    end
end
