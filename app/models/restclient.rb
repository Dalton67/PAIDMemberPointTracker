require 'rubygems'
require 'httparty'

class RestClient
    include HTTParty
    base_uri "tamu-paid.herokuapp.com/api/v1/"

    def events
        self.class.get('/events')
    end 
    def event(id)
        self.class.get('/events/'+id.to_s)
    end 
end 