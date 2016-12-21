class LikesController < ApplicationController
  before_action :require_login, except: [:create, :destroy]
  # before_action :require_correct_user, only: [:create, :destroy]
  # before_action :restrict_likes, only: [:create]

  def create
    if Like.where(user_id: session[:user_id], idea_id: params[:id]).count < 1
      @like = Like.create(user_id: session[:user_id], idea_id: params[:id])
    else
      flash[:notice] = "You've already liked this idea!"
    end
    # session[:idea_id] = Idea.find(params[:id])
    @like_count = Like.where(user_id: params[:id]).all
    puts @like_count
    redirect_to '/bright_ideas'
  end

  def destroy
  end
end
