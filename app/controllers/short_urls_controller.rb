class ShortUrlsController < ApplicationController
  before_action :load_resource, only: :show

  def show
    @short_url = ShortUrl.find_by(slug: params[:id])
    redirect_to @short_url.original
  end

  private

  def load_resource
    @short_url = ShortUrl.find_by(slug: params[:id])
    raise ActiveRecord::RecordNotFound if @short_url.nil?
  end
end
