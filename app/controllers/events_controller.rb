class EventsController < ApplicationController
    
  before_action :confirm_logged_in
    def index
        @events = Event.order(:id)
      end
    
      def show
        @event = Event.find(params[:id])
        @member = Member.new
      end
    
      def new
        @events = Event.new
      end
    
      def create
        @events = Event.new(event_params)
        if @events.save
          redirect_to(events_path)
        else
          render('new')
        end
      end
    
      def edit
        @event = Event.find(params[:id])
      end
    
      def update
        @event = Event.find(params[:id])
        if @event.update_attributes(event_params)
          redirect_to(event_path(@event))
        else
          render('new')
        end
      end
    
      def delete
        @events = Event.find(params[:id])
      end
    
      def destroy
        @events = Event.find(params[:id])
        @events.destroy
        redirect_to(events_path)
      end
    
      private
      def event_params
        params.require(:event).permit(:id, :title, :date, :semester, :points_worth)
      end
    end
