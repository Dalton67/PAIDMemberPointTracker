# frozen_string_literal: true

class Member < ApplicationRecord
  has_and_belongs_to_many :events
  after_initialize :init
  require 'csv'
  require 'restclient.rb'
  require 'json'
  def init
    self.fall_points ||= 0
    self.spring_points ||= 0
    self.total_points ||= 0
  end

  def self.import(file, points, id, semester)
    data = []
    event = Event.find(id)
    CSV.foreach(file.path, headers: true) do |row|
      member = Member.find_by(email: row['email'])
      if member
        if semester == 'Fall'
          member.update_attribute(:fall_points, points.to_i + member.fall_points)
        else
          member.update_attribute(:spring_points, points.to_i + member.spring_points)
        end
        member.update_attribute(:total_points, member.fall_points + member.spring_points)
        if  member.events.exclude? event
          member.events << event
        end 
        member.save()
      else
        data.push(row['email'])
      end
    end
    return data
  end
  def self.api(id)
    r = RestClient.new
    semester = "Fall"
    result = r.event(9)
    v = JSON.parse(result.body)
    points = v["points"].to_i
    data = []
    event = Event.find(1)
      v["sign_ins"].each do |row|
        member = Member.find_by(email: row['email'])
        if member
          if semester == 'Fall'
            member.update_attribute(:fall_points, points.to_i + member.fall_points)
          else
            member.update_attribute(:spring_points, points.to_i + member.spring_points)
          end
          member.update_attribute(:total_points, member.fall_points + member.spring_points)
          if  member.events.exclude? event
            member.events << event
          end 
          member.save()
        else
          data.push(row['email'])
        end
      end
    return data
  end 
  

  def self.search(search)
    if search
      Member.where('first_name ILIKE :search OR last_name ILIKE :search OR email ILIKE :search', search: "%#{search}%")
    else
      Member.all.order('created_at DESC')
    end
  end

  def self.SORTS_ALL
    [
      {:name => "Total Points", :id => 'total_points'},
      {:name => "Fall Points", :id => 'fall_points'},
      {:name => "Spring Points", :id => 'spring_points'},
      {:name => "First Name", :id => 'first_name'},
      {:name => "Last Name", :id => 'last_name'}
    ]
  end
end
