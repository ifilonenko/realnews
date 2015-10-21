class UsersController < ApplicationController
  include UsersHelper
  include SessionsHelper
  def create
    @user = User.new(user_params)
    @user.password = params[:user][:password]
    @success = false
    @image = nil
    @user.save
    if @user.errors.empty? 
      if !params[:user][:propic].blank? 
        @image = Image.create(file: params[:user][:propic], imageable_type: 'User', imageable_id: @user.id)
        @user.update_attributes(propic_url: @image.file.url)
      end
      @success = true
      save_session_for_user(@user)
    end
    respond_to do |format|
      format.html { 
        if @success
          redirect_to root_path
        else
          render text: 'user was not successfully created'
        end
      }
      format.json {
        if @success
          render json: { success: true, route: '/' } 
        else
          alerts = render_to_string(partial: 'shared/alert.html.erb', locals: { model: @user })
          render json: { errors: @user.errors.full_messages, success: @success, alerts: alerts }
        end
      }
    end
  end
  def profile
  end
  private
  def user_params
    params.require(:user).permit(:fname, :lname, :bio, :email)
  end
end
