class ApplicationController < ActionController::API
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :user_banned, if: :authenticate_user!

  $bantime = 1.year.from_now
  $maxpenaltys = 3

  def isadmin
    render json: { message: 'You have no rights to do this'}, status: :forbidden unless current_user.admin?
  end

  def owner
    if params[:user_id] != current_user.id && !current_user.admin?
      render json: { message: 'You have no rights to do this' }, status: :forbidden
    end
  end

  def user_banned
    if current_user.banned_to != nil && current_user.banned_to > Time.now
      render json: { ban_time: current_user.banned_to }, status: :forbidden
    elsif current_user.banned_to != nil && current_user.banned_to < Time.now
      current_user.banned_to = nil
      current_user.save
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end