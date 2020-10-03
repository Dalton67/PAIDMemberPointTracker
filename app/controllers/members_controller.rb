class MembersController < ApplicationController
  
  before_action :confirm_logged_in
  
  def index
    @members = Member.order(:id)
    respond_to do |format|
      format.html {render 'index'}
      format.csv {send_data @members.to_csv }
    end
  end
  def missing
    @missing_members = session[:data]#[ "Buy Milk", "Buy Soap", "Pay bill", "Draw Money" ]
  end 
  def import
    data = Member.import(params[:file],params[:points_worth])
    session[:data] = data
    redirect_to missing_members_path  #(data :data)
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
