class UsersController < ApplicationController
  before_action :signed_in_user, only: :show
  before_action :find_user_by_id, only: :show

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params_create)

    if @user.save
      sign_in @user
      flash[:success] = "You've entered the system."
      redirect_to @user
    else
      render 'new'
    end
  end

  private

  def find_user_by_id
    @user = User.find_by!(id: params[:id])
  end

  def user_params_create
    params.require(:user).permit(
      :email,
      :first_name,
      :last_name,
      :password,
      :admin
    )
  end
end
