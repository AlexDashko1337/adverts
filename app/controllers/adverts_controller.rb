class AdvertsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_advert, only: %i[ show update destroy approve ]
  before_action :owner, only: %i[ update destroy ]

  # GET /adverts/unposted
  def unposted
    if current_user.moderator? || current_user.admin?
      @adverts = Advert.where(approved: false)
      render json: @adverts, each_serializer: AdvertSerializer
    else
      render json: {message: 'moderators only'}, status: :forbidden
    end  
  end

  # PATCH /adverts/unposted/[:id]
  def approve
    if current_user.moderator? || current_user.admin?
      @advert.approved = true
      if @advert.save
        render json: @advert, status: :ok, location: @advert
      else
        render json: @advert.errors, status: :unprocessable_entity
      end
    end
  end

  # GET /adverts
  def index
    if params[:user_id].present? 
      @adverts = Advert.find_by(user_id: params[:user_id], approved: true)
      render json: @adverts, each_serializer: AdvertSerializer
    else
      @adverts = Advert.find_by(approved: true)
      render json: @adverts, each_serializer: AdvertSerializer
    end
  end

  # GET /adverts/1
  def show
    render json: @advert, serializer: AdvertSerializer
  end

  # POST /adverts
  def create
    @advert = current_user.adverts.new(advert_params)

    if @advert.save
      render json: @advert, status: :created, location: @advert
    else
      render json: @advert.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /adverts/1
  def update
    if @advert.update(advert_params)
      render json: @advert
    else
      render json: @advert.errors, status: :unprocessable_entity
    end
  end

  # DELETE /adverts/1
  def destroy
    @user = User.find(@advert.user_id)
    if current_user.id != @user.id && current_user.admin?
      @user.penalty = @user.penalty+1
      @user.save
      if @user.penalty >= MAXPENALTYS
        @user.banned_to = BANTIME
        render json: { message: 'User was banned', user: @user, bantime: @user.banned_to }, status: :ok
        @user.penalty = 0
        @user.save
      end
    end
    @advert.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advert
      @advert = Advert.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def advert_params
      params.permit(:context)
    end
end
