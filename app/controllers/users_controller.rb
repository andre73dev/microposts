class UsersController < ApplicationController
  before_action :collect_user, only: [:edit, :update]
  
  def show # 追加
    if User.exists?(params[:id])
      @user = User.find(params[:id]) 
      if @user.microposts.any?
        @microposts = @user.microposts.page(params[:page]).per(5).order(created_at: :desc)
      end  
    else
      redirect_to root_url
    end      
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
    @user = User.find(params[:id])
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

  def followings
    @user = User.find(params[:id])
    @followings = @user.following_users.page(params[:page]).per(10).order(id: :desc)
  end
  
  def followers
    @user = User.find(params[:id])
    @followers = @user.follower_users.page(params[:page]).per(10).order(id: :desc)
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :location)
  end
  
  def collect_user
    user = User.find(params[:id])
    if user != current_user
      flash[:danger] = "Invalid user!"
      redirect_to root_url
    end
  end

end
