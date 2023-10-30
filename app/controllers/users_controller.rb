class UsersController < ApplicationController
  before_action :authenticate_user!

  def forgotten_password
    @users = User.all

    if request.post?
      user = User.find_by_email(params[:email])

      if user
        user.password = params[:new_password]
        if user.save
          flash[:notice] = "Password successfully changed."
          redirect_to root_path
        else
          flash[:alert] = "Password change failed."
          render :forgotten_password
        end
      else
        flash[:alert] = "Email not found."
        redirect_to root_path
      end
    end
  end
end
