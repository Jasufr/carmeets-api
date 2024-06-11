class Api::V1::CommentsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, only: [:create]
  before_action :set_meeting

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

  private

  def set_meeting
    @meeting = Meeting.find(params[:meeting_id])
    authorize @meeting, :show?
  end

  def comment_params
    params.require(:comment).permit(:content)
  end

  def render_error
    render json: { errors: @comment.errors.full_messages },
      status: :unprocessable_entity
  end
end
