# frozen_string_literal: true

class MembersController < ApplicationController
  before_action :confirm_logged_in

  def index
    if params[:search] != ''
      @searched_members = Member.search(params[:search]) if params[:search]
      puts "search"
      puts params[:search]
    else
      @searched_members = Member.all
      puts "non-search"
    end

    if params[:order] == 'total_points'
      @members = @searched_members.all.order('total_points').reverse_order
      puts "total_points"
    elsif params[:order] == 'fall_points'
      @members = @searched_members.all.order('fall_points').reverse_order
      puts "fall_points"
    elsif params[:order] == 'spring_points'
      @members = @searched_members.all.order('spring_points').reverse_order
      puts "spring_points"
    elsif params[:order] == 'first_name'
      @members = @searched_members.all.order('first_name')
      puts "first_name"
    elsif params[:order] == 'last_name'
      @members = @searched_members.all.order('last_name')
      puts "last_name"
    else
      @members = @searched_members.all.order('total_points').reverse_order
      puts "default (total_points)"
    end
  end

  def missing
    @missing_members = session[:data]
  end

  def import
    data = Member.import(params[:file], params[:points_worth])
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

  private

  def member_params
    params.require(:member).permit(:id, :first_name, :last_name, :email, :fall_points, :spring_points, :total_points, :search, :order)
  end
end
