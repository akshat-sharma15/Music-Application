class UserProfilesController < ApplicationController
  before_action :permit_action, only: %i[allusers delete]
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    @user = @current_user
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def show
    @user = current_user
    render json: @user
  end

  def allusers
    @user = User.all
    render json: @user
  end

  def delete
    @user = User.find(params[:id])
    if @user.destroy
      # User.destroy_all
      render json: { message: 'User account deleted' }
    else
      render json: { message: 'User not deleted' }
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :role, :dob, :gender)
  end
end
