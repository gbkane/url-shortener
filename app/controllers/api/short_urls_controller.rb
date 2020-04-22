class Api::ShortUrlsController < Api::BaseController
  before_action :load_resource, except: [:index, :create]
  def index
    @short_urls = ShortUrl.order(id: :desc).page(params[:page])
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

  def update
    if @short_url.update(url_params)
      render :show
    else
      render json: @short_url.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @short_url.destroy!
    head :no_content
  end

  def expire
    @short_url.expire!
    render :show
  end

  private

  def url_params
    params.require(:short_url).permit(:slug, :original, :expired_at)
  end

  def load_resource
    @short_url = ShortUrl.find(params[:id])
  end

end
