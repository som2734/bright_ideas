class UsersController < ApplicationController
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update]
  def new
    render 'new'
  end

  def show
    @user = User.find(params[:id])
    @my_idea = Idea.joins(:user).where(user_id: @user.id).all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "You have registered successfully! Please login"
      redirect_to "/main"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  def profile
    @user = User.find(params[:id])
    @my_ideas = Idea.where(user_id: params[:id]).all
    @like_count = Like.where(idea_id: @my_ideas).all
    render 'profile'
  end

  private
    def user_params
      params.require(:user).permit(:name, :alias, :email, :password, :password_confirmation)
    end

end
