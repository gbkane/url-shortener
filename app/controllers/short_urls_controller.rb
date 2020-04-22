class ShortUrlsController < ApplicationController
  before_action :load_resource, only: :show

  def show
    if @short_url.active?
      redirect_to @short_url.original
    else
      render :show
    end
  end

  private

  def load_resource
    @short_url = ShortUrl.find_by(slug: params[:id])
    raise ActiveRecord::RecordNotFound if @short_url.nil?
  end
end
