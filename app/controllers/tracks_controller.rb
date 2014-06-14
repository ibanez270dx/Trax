class TracksController < ApplicationController
  before_filter :require_user

  def new
    @track = Track.new
  end

  def create
    @track = current_user.tracks.new track_params
    if params[:track][:soundcloud_id].present?
      render(json: { saved: @track.save, html: render_to_string(partial: 'dashboard/tracks', formats: [:html], locals: { tracks: current_user.reload.tracks }) }) and return
    else
      render(json: { valid: @track.valid?, html: render_to_string(partial: 'track/add/details', formats: [:html]) }) and return
    end
  end

  private

    def track_params
      params.require(:track).permit(:title, :description, :instrument, :time_signature, :duration, :soundcloud_id, :soundcloud_uri, :soundcloud_permalink_url)
    end

end
