# frozen_string_literal: true

class ApplicationController < ActionController::Base
  private

  def confirm_logged_in
    unless session[:user_id]
      flash[:notice] = 'Please log in'
      redirect_to(access_login_path)
      # prevents requested action from running
    end
  end
end
