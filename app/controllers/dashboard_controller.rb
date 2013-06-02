class DashboardController < ApplicationController
  before_filter :require_user

  def index
    @tracks = current_user.tracks
  end

  def update
    render json: {
      tracks: render_to_string(partial: 'dashboard/tracks', formats: [:html], locals: { tracks: current_user.tracks })
    }
  end
end
