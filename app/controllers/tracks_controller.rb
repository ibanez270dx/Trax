class TracksController < ApplicationController
  before_filter :require_user

  def create
    @track = current_user.tracks.new track_params
    render(json: { saved: @track.save }) and return unless params[:track][:soundcloud_id].blank?
    render(json: { valid: @track.valid?, html: render_to_string(partial: 'track/add/details', formats: [:html]) }) and return
  end

  private

    def track_params
      params.require(:track).permit(:title, :description, :instrument, :time_signature, :duration, :soundcloud_id, :soundcloud_uri, :soundcloud_permalink_url)
    end

end
