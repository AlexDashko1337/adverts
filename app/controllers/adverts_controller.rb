class AdvertsController < ApplicationController
  before_action :set_advert, only: %i[ show update destroy ]
  before_action :authenticate_user!, only: %i[ create destroy update]

  # GET /adverts
  def index #/users/[:user_id]/adverts #/adverts
    if params[:user_id].present? 
      @adverts = Advert.find_by(user_id: params[:user_id])
      render json: @adverts, each_serializer: AdvertSerializer
    else
      @adverts = Advert.all
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
    #@advert = Advert.new(advert_params)

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
