class Api::V1::CommentsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, only: [:create, :update, :destroy]
  before_action :set_meeting, only: [:create, :update, :destroy]
  before_action :set_comment, only: [:update, :destroy]

  def index
    @meetings = policy_scope(Comment)
  end

  def create
    @comment = @meeting.comments.build(comment_params)
    @comment.user = current_user
    authorize @comment
    if @comment.save
      render json: @comment, status: :created
    else
      render_error
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment, status: :ok
    else
      render_error
    end
  end

  def destroy
    @comment.destroy
    head :no_content
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
    authorize @meeting, :show?
  end

  def set_comment
    @comment = @meeting.comments.find(params[:id])
    authorize @comment
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def render_error
    render json: { errors: @comment.errors.full_messages },
      status: :unprocessable_entity
  end
end
