class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i[ create ]
  before_action :set_user, only: %i[ show update destroy create_admin ]
  before_action :isadmin, only: %i[ create_admin ]
  before_action :admin_or_owner, only: %i[ update destroy ]

  def admin_or_owner
    if current_user.id != params[:id] || current_user.admin? 
      render json: {message: 'You have no rights to do this'}, status: :forbidden
    end
  end

  # PATCH /users/set_admin
  def create_admin
    @user.role = :moderator
    if @user.save
      render json: @user.role, status: :accepted
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # GET /users
  def index
    @users = User.all
    render json: @users, adapter: nil
  end

  # GET /users/1
  def show
    render json: @user, serializer: UsersSerializer
  end

=begin
  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end
=end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end