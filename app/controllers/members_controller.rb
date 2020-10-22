# frozen_string_literal: true
require 'csv'

class MembersController < ApplicationController
  before_action :confirm_logged_in

  def index
    @members = Member.all
    @members = Member.search(params[:search]).order('created_at DESC') if params[:search]
  end

  def missing
    @missing_members = session[:data]
  end

  def import
    data = Member.import(params[:file], params[:points_worth], params[:semester])
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
    params.require(:member).permit(:id, :first_name, :last_name, :email, :fall_points, :spring_points, :spring_points, :search)
  end
end
