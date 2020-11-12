# frozen_string_literal: true

class GeneralmemberController < ApplicationController

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
      @searched_members = @searched_members.all.order('total_points').reverse_order
      # puts "total_points"
    elsif params[:sort] == 'fall_points'
      @searched_members = @searched_members.all.order('fall_points').reverse_order
      # puts "fall_points"
    elsif params[:sort] == 'spring_points'
      @searched_members = @searched_members.all.order('spring_points').reverse_order
      # puts "spring_points"
    elsif params[:sort] == 'first_name'
      @searched_members = @searched_members.all.order('first_name')
      # puts "first_name"
    elsif params[:sort] == 'last_name'
      @searched_members = @searched_members.all.order('last_name')
      # puts "last_name"
    else
      @searched_members = @searched_members.all.order('total_points').reverse_order
      # puts "default (total_points)"
    end

    @members = @searched_members.paginate(page: params[:page], per_page: 50)

  end

  private

  def member_params
    params.require(:member).permit(:id, :first_name, :last_name, :email, :fall_points, :spring_points, :total_points)
  end
end
