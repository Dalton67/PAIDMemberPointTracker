# frozen_string_literal: true

class GeneralmemberController < ApplicationController
  def index
    @members = Member.order(:id)

    @members = Member.paginate(:page => params[:page], :per_page => 50)
  end

  private

  def member_params
    params.require(:member).permit(:id, :first_name, :last_name, :email, :fall_points, :spring_points, :total_points)
  end
end
