class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  def require_login
  redirect_to '/main' if session[:user_id] == nil
  end
  def current_user
   User.find(session[:user_id]) if session[:user_id]
  end
  def require_correct_user
    user = User.find(params[:id])
    redirect_to "/bright_ideas" if current_user != user
  end
  def restrict_likes
    liked = Like.find_by(user_id: session[:user_id], idea_id: params[:id])
    redirect_to "likes#create" if liked == false
    # else
    #   flash[:notice] = "You've already liked this idea!"
    #   redirect_to :back
    #   # redirect_to "/bright_ideas"
    # end
  end

  helper_method :current_user, :require_login, :require_correct_user
end
