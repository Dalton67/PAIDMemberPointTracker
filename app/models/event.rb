# frozen_string_literal: true
require 'date'

class Event < ApplicationRecord
  has_and_belongs_to_many :members
  after_initialize :init
  # require 'restclient.rb'
  require 'json'
  def init
    self.points_worth ||= 1
    self.mapped_id ||= -1
  end
  def self.apiEvents()
    r = RestClient.new
    result = r.events()
    response = JSON.parse(result.body)
    response["events"].each do |mapped_event|
      if !Event.where(mapped_id: mapped_event["id"]).exists? 
        e = Event.create(
          :mapped_id=>  mapped_event["id"],
          :points_worth => mapped_event["points"],
          :title => mapped_event["name"],
          :date => mapped_event["date"]
        )

        # making date prettier
        date_obj = Date.parse(e.date)
        e.date = date_obj.to_s

        # assigning semester based off date's month
        if (date_obj.month > 7 && date_obj.month <= 12)
          e.semester = "Fall"
        elsif (date_obj.month >= 1  && date_obj.month < 7)
          e.semester = "Spring"
        end

        e.save()
      end 
    end 
  end 
end
