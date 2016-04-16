class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  
  def show # 追加
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # ここを修正
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find_by_id(params[:id])
    if @user == current_user
      render 'edit'
    else    
      flash[:danger] = "Invalid User!"
      redirect_to root_path
    end

    #if (@user != nil && current_user == @user)
    #  render 'edit'
    #else
    #  flash[:danger] = "Invalid User!"
    #  redirect_to root_path
    #end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Update Profile"
      redirect_to @user
    else
      render 'edit'
    end
  end    
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :location)
  end

end
