class Api::V1::MeetingsController < Api::V1::BaseController
  def index
    @meetings = policy_scope(Meeting)
  end
end
