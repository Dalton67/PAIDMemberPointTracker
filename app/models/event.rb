# frozen_string_literal: true

class Event < ApplicationRecord
  has_and_belongs_to_many :members
  after_initialize :init
  require 'restclient.rb'
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
      # event = 
      if !Event.where(mapped_id: mapped_event["id"]).exists? 
        e = Event.create(
          :mapped_id=>  mapped_event["id"],
          :points_worth => mapped_event["points"],
          :title => mapped_event["name"]
        )
        e.save()
      end 
    end 
  end 
end
