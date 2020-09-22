class MembersController < ApplicationController
  def index
    @members = Member.order(:id)
    @events = Event.order(:id)
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new
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

  private

  def member_params
    params.require(:member).permit(:id, :first_name, :last_name, :email, :fall_points, :spring_points, :total_points)
  end
end
