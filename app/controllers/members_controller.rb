# frozen_string_literal: true
require 'csv'

class MembersController < ApplicationController
  before_action :confirm_logged_in

  def index
    @searched_members = Member.all
    @members = Member.all

    if params[:search] != ''
      @searched_members = Member.search(params[:search]) if params[:search]
      puts params[:search]
    else
      @searched_members = Member.all
    end

    if params[:sort] == 'total_points'
      @members = @searched_members.all.order('total_points').reverse_order
      # puts "total_points"
    elsif params[:sort] == 'fall_points'
      @members = @searched_members.all.order('fall_points').reverse_order
      # puts "fall_points"
    elsif params[:sort] == 'spring_points'
      @members = @searched_members.all.order('spring_points').reverse_order
      # puts "spring_points"
    elsif params[:sort] == 'first_name'
      @members = @searched_members.all.order('first_name')
      # puts "first_name"
    elsif params[:sort] == 'last_name'
      @members = @searched_members.all.order('last_name')
      # puts "last_name"
    else
      @members = @searched_members.all.order('total_points').reverse_order
      # puts "default (total_points)"
    end
  end

  def missing
    @missing_members = session[:data]
    @points = session[:points_worth]
    @semester = session[:semester]
    @mapped_id = session[:mapped_id]
    @id = session[:id]
    @type = session[:type]
  end

  def import
    session[:return_to] ||= request.referer
    begin
      data = Member.import(params[:file],params[:points_worth],params[:id],params[:semester])
      session[:data] = data
      session[:points_worth] = params[:points_worth]
      session[:semester] = params[:semester]
      session[:id] = params[:id]
      session[:type] = params[:type]
      if !data.empty?
        redirect_to missing_members_path
      else
        redirect_to(members_path)
      end
    rescue Exception => exc
      flash[:error] = "You must upload a csv."
      redirect_to session.delete(:return_to)
    end
  end

  def import_members_from_csv
    if !params[:file] 
      redirect_to(members_bulk_create_path)
      flash[:notice] = "No file specified - please add csv"
    else
      new_member_count = Member.import_members(params[:file])
      redirect_to(members_path)
      flash[:notice] = "#{new_member_count} new members created successfully"
    end
  end

  def apimport
    data = Member.api(params[:mapped_id].to_i,params[:semester])
    session[:data] = data
    session[:points_worth] = params[:points_worth]
    session[:semester] = params[:semester]
    session[:mapped_id] = params[:mapped_id]
    session[:id] = params[:id]

    # if there are members not in our database
    if !data.empty?
      redirect_to missing_members_path
    else
       redirect_to(members_path)
       count = Member.get_attendee_count()
      flash[:notice] = "#{count} members successfully received #{session[:points_worth]} points"
    end
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new
    @member.email = params[:email] if params[:email]
    if params[:semester] == "Fall"
      @member.fall_points = params[:points] if params[:points]
    else 
      @member.spring_points = params[:points] if params[:points]
    end 
    @member.total_points = @member.fall_points+@member.spring_points
    # @member.save()
  end

  def bulk_create
    #flash[:notice] = "Creating members..."
  end

  def create
    @member = Member.new(member_params)
    event = nil
    if session[:type] == "api"
      event = Event.find_by(mapped_id: session[:mapped_id])
    elsif session[:type] == "file"
      event = Event.find_by(id: session[:id])
    else
      event = nil
    end 

    if !event.nil? 
      if @member.events.exclude? event 
        @member.events << event
      end
    end

    if @member.save
      if !session[:data].nil? 
        if !session[:data].empty?
          session[:data].delete(@member.email)
          redirect_to missing_members_path
        else 
          redirect_to(members_path)
        end
      else
        redirect_to(members_path)
      end
    else
      render('new')
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update_attributes(member_params)
      @member.total_points = @member.fall_points+@member.spring_points
      @member.save()
      redirect_to(member_path(@member))
    else
      render('new')
    end
  end

  def delete
    @member = Member.find(params[:id])
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to(members_path)
  end

  def reset
    @members = Member.all
    @member = Member.new
  end

  def reset_members
    Member.delete_all
    redirect_to(members_path)
  end

  def export
    file = "#{Rails.root}/public/PAIDMemberData.csv"


    table = Member.all;0
    wanted_columns = [:id, :first_name, :last_name, :email, :fall_points, :spring_points, :total_points ]

    columns = %w(id first_name last_name email fall_points spring_points total_points)
    CSV.open( file, 'w' ) do |writer|
      writer << wanted_columns
      #columns(&:humanize)
      #table.first.attributes.map { |a,v| a }
      table.each do |s|
        writer << s.attributes.values_at(*columns)
      end
    end
    redirect_to("/PAIDMemberData.csv")
    #redirect_to(members_path)
  end

  private

  def member_params
    params.require(:member).permit(:id, :first_name, :last_name, :email, :fall_points, :spring_points, :total_points, :search, :sort, :events)
  end
end
