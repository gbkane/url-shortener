class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  private
  def render_404(exception = nil)
    render :file => "#{Rails.root}/public/404.html", status: 404, layout: false
  end
end
