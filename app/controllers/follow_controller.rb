class FollowController < ApplicationController
  before_action :set_user, only: %i[ following followers ]

  def following
    @following = @user.follows
  end

  def followers
    @followers = User.joins(:following).where('following.follow_id': @user.id)
  end

  def create
    @follow = Following.new(user_id: session[:id], follow_id: params[:id])
    if @follow.save
      redirect_to user_path(params[:id]), notice: "Followed!"
    else
      flash[:alert] = "You are already following this user!"
      redirect_to user_path(params[:id])
    end
  end

  def destroy
    Following.find_by(user_id: session[:id], follow_id: params[:id]).destroy!
    if params[:source] == "list"
      redirect_to "/users/#{session[:id]}/following", notice: "Unfollowed!"
    elsif params[:source] == "user"
      redirect_to user_path(params[:id]), notice: "Unfollowed!"
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
