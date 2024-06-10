class Api::V1::MeetingsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_meeting, only: [ :show, :update, :destroy ]

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

  def create
    @meeting = Meeting.new(meeting_params)
    @meeting.user = current_user
    authorize @meeting
    if @meeting.save
      render :show, status: :created
    else
      render_error
    end
  end

  def destroy
    @meeting.destroy
    head :no_content
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
