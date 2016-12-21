class IdeasController < ApplicationController
  before_action :require_login, only: [:index, :create]
  def index
    @user = User.find(session[:user_id])
    @all_ideas = Idea.all
    render 'index'
  end

  def create
    @user = User.find(session[:user_id])
    @idea = Idea.create(idea_params)
    redirect_to :back
  end

  def show
    @liked_idea = Idea.all.where(id: params[:id])
    @likes = Like.all.where(idea_id: params[:id])
    render 'status'
  end

  def destroy
    @rmv_idea = Idea.find(params[:id])
    # @user_idea = User.find(session[:user_id])
    @user_idea = @rmv_idea.user.id
    @rmv_idea.destroy if @user_idea == session[:user_id]
    redirect_to '/bright_ideas'
    # @rmv_idea.destroy if @user_idea == current_user
  end

  private
    def idea_params
      params.require(:idea).permit(:content, :user_id)
    end
end
