class DashboardController < ApplicationController
  before_filter :require_user

  def index
    @tracks = current_user.tracks
  end

end
