class Member < ApplicationRecord
  has_and_belongs_to_many :events
  after_initialize :init
  require 'csv'
  def init
    self.fall_points ||= 0
    self.spring_points ||= 0
    self.total_points ||= 0
  end
  def self.to_csv
    attributes = %w{email}
    CSV.generate(headers:true) do |csv|
      csv << attributes
      all.each do |member|
        csv<< member.attributes.values_at(*attributes)
      end
    end
  end 
  def self.to_csv_1(file,points)
    data = Array.new
    CSV.foreach(file.path,headers:true) do |row|
      member = Member.find_by(email: row['email'])
      if !member
        data.push(row['email'])
      end 
    end
    if !data.empty?
      puts data
      attributes = %w{email}
      CSV.generate(headers:true) do |csv|
        csv << attributes
        data.each do |email|
          csv << [email] 
        end
      end
    end
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
  # def self.export(file,p)
end
