class CommentsController < ApplicationController
  before_action :authenticate_user!, except: %i[ index show ]
  before_action :set_comment, only: %i[ show update destroy ]
  before_action :owner, only: %i[ update destroy ]

  # GET /comments
  def index
    if params[:advert_id].present?
      @comments = Comment.find_by(advert_id: params[:advert_id])
      render json: @comments, each_serializer: CommentSerializer
    end
  end

  # GET /comments/1
  def show
    render json: @comment, serializer: CommentSerializer
  end

  # POST /comments
  def create
  @comment = current_user.comments.new(comment_params)
  @comment.user_id = current_user.id
    if @comment.save
      render json: @comment, status: :created
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /comments/1
  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /comments/1
  def destroy
    @user = User.find(@comment.user_id)
    if current_user.id != @user.id && current_user.admin?
      @user.penalty = @user.penalty+1
      @user.save
      render json: {message: @user.penalty}
      if @user.penalty >= MAXPENALTYS
        @user.banned_to = BANTIME
        @user.penalty = 0
        @user.save
      end
    end
    @comment.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.permit(:context, :advert_id)
    end
end
