class SessionsController < ApplicationController
  def index
    redirect_to root_path
  end
  include SessionsHelper
  def create
    alerts=''
    x = User.find_by_email(params[:user][:email].downcase)
    success = true
    if x && x.authenticate(params[:user][:password])
      save_session_for_user(x)
    else
      alerts = render_to_string(partial: 'shared/login_alerts.html.erb')
      success = false
    end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { render json: { success: success, alerts: alerts, route: '/' } } 
    end
  end
  def update
  end
  def destroy
    @active_session = active_session
    @active_session.disable if @active_session
    clear_session_cookie
    redirect_to root_path
  end  
end
