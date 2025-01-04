class StaticPagesController < ApplicationController
  before_action :set_flickr_client

  def index
    @user = params[:user_id]

    if @user
      begin
        @photos = @flickr.photos.search(user_id: @user, per_page: 100)
      rescue Flickr::FailedResponse
        flash[:error] = "User not found"
      end
    end
  end

  private

  def set_flickr_client
    @flickr = Flickr.new Figaro.env.flickr_api_key, Figaro.env.flickr_shared_secret
  end
end
