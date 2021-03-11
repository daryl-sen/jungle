class UsersController < ApplicationController
  before_action :set_user, only: [:destroy]

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to '/login'
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
