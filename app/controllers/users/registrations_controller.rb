class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    user = User.create(user_params)
    respond_with(user)
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password)
  end

  def respond_with(user)
    if user.persisted?
      render json: { message: 'Signed up sucessfully.'}, status: :ok 
    else
      render json: user.errors.full_messages, status: :bad_request
    end
  end

  def register_success
    render json: {
      message: 'Signed up sucessfully.',
      user: current_user
    }, status: :ok
  end

  def register_failed
    render json: { message: 'Something went wrong.' }, status: :unprocessable_entity
  end
end