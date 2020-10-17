# frozen_string_literal: true

class Member < ApplicationRecord
  has_and_belongs_to_many :events
  after_initialize :init
  require 'csv'
  def init
    self.fall_points ||= 0
    self.spring_points ||= 0
    self.total_points ||= 0
  end

  def self.import(file, points, semester)
    data = []
    CSV.foreach(file.path, headers: true) do |row|
      member = Member.find_by(email: row['email'])
      if member
        puts points
        if semester == 'Fall'
          member.update_attribute(:fall_points, points.to_i + member.fall_points)
        else
          member.update_attribute(:spring_points, points.to_i + member.spring_points)
        end
        member.update_attribute(:total_points, member.fall_points + member.spring_points)
        member.save
      else
        data.push(row['email'])
      end
    end
    data
  end

  def self.search(search)
    if search
      Member.where('first_name ILIKE :search OR last_name ILIKE :search OR email ILIKE :search', search: "%#{search}%")
    else
      Member.all.order('created_at DESC')
    end
  end
end
