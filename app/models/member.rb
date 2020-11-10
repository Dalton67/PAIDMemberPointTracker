# frozen_string_literal: true

class Member < ApplicationRecord
  has_and_belongs_to_many :events
  after_initialize :init
  require 'csv'
  require 'json'
  require 'restclient.rb'
  def init
    self.fall_points ||= 0
    self.spring_points ||= 0
    self.total_points ||=  self.fall_points + self.spring_points
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

  def self.import_members(file)
    new_member_count = 0
    CSV.foreach(file.path, headers: true) do |row|
      member = Member.find_by(email: row['Email Address'])
      
      # if member is already in DB, no need to add
      if member
        next  
      else
        new_member = Member.new
        new_member.update_attribute(:email, row['Email Address'])
        new_member.update_attribute(:first_name, row['First Name: (Ex: Evan)'])
        new_member.update_attribute(:last_name, row['Last Name (Ex: Vestal)'])
        new_member.save()
        new_member_count += 1
      end
    end
    return new_member_count
  end

  def self.api(id,semester)
    r = RestClient.new
    # semester = semester
    result = r.event(id)
    v = JSON.parse(result.body)
    puts "hello"
    puts v
    points = v["points"].to_i
    data = []
    event = Event.find_by(mapped_id: id)
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
