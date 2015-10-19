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
    else
      @success = false
    end
    redirect_to root_path
  end
  def profile
  end
  private
  def user_params
    params.require(:user).permit(:fname, :lname, :bio, :email)
  end
end
