class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(_resource, _opts = {})
    unless current_user.nil?
      #render json: request.env['warden-jwt_auth.token'], status: :ok
      render json: {
        message: 'You are logged in.',
        user: current_user,
        token: request.env['warden-jwt_auth.token']
      }, status: :ok
    else
      render json: {
          message: 'Something went wrong',
      }, status: :unprocessable_entity
    end
  end

  def respond_to_on_destroy
    log_out_success && return if current_user

    log_out_failure
  end

  def log_out_success
    render json: { message: 'You are logged out.' }, status: :ok
  end

  def log_out_failure
    render json: { message: 'Hmm nothing happened.' }, status: :unauthorized
  end
end