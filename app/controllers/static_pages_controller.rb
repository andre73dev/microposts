class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost = current_user.microposts.build
      @feed_items = current_user.feed_items.includes(:user).page(params[:page]).per(5).order(created_at: :desc)
    end
  end
end
