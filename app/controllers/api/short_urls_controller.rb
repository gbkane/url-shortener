class Api::ShortUrlsController < Api::BaseController
  before_action :load_resource, only: [:show, :destroy, :expire]
  def index
    @short_urls = ShortUrl.order(created_at: :desc).page(params[:page])
    render :index
  end

  def create
    @short_url = ShortUrl.new(url_params)
    if @short_url.save
      render :show, status: :created
    else
      render json: @short_url.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    render :show
  end

  def destroy
    @short_url.destroy!
    render json: @short_url
  end

  def expire
    @short_url.expire! unless @short_url.expired?
    render json: @short_url
  end

  private

  def url_params
    params.require(:short_url).permit(:slug, :original)
  end

  def load_resource
    @short_url = ShortUrl.find(params[:id])
  end

end
