# frozen_string_literal: true
require 'csv'

class MembersController < ApplicationController
  before_action :confirm_logged_in

  def index
    @searched_members = Member.all
    @members = Member.all

    if params[:search] != ''
      @searched_members = Member.search(params[:search]) if params[:search]
      # puts "search"
      puts params[:search]
    else
      @searched_members = Member.all
      # puts "non-search"
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
  end

  def import
    data = Member.import(params[:file],params[:points_worth],params[:id],params[:semester])
    session[:data] = data
    redirect_to missing_members_path
  end

  def apimport
    data = Member.api(params[:mapped_id].to_i)
    session[:data] = data
    redirect_to missing_members_path
  end 
  
  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new
    @member.email = params[:email] if params[:email]
  end

  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to(members_path)
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
    redirect_to(members_path)
  end

  private

  def member_params
    params.require(:member).permit(:id, :first_name, :last_name, :email, :fall_points, :spring_points, :total_points, :search, :sort, :events)
  end
end
