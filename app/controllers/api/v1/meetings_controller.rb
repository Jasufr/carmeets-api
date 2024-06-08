class Api::V1::MeetingsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_meeting, only: [ :show, :update ]

  def index
    @meetings = policy_scope(Meeting)
  end

  def show
  end

  def update
    # @meeting.update(meeting_params)
    if @meeting.update(meeting_params)
      render :show
    else
      render_error
    end
  end

  private

  def set_meeting
    @meeting = Meeting.find(params[:id])
    authorize @meeting
  end

  def meeting_params
    params.require(:meeting).permit(:name, :address, :description, :picture)
  end

  def render_error
    render json: { errors: @meeting.errors.full_messages },
      status: :unprocessable_entity
  end
end
