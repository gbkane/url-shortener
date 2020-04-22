require 'rails_helper'

RSpec.describe "ShortUrl requests", type: :request do

  context 'when active' do
    let(:url){ create(:url) }
    it 'redirects to original url' do
      get url.sharing_url
      expect(response).to redirect_to(url.original)
    end
  end

  context 'when expired' do
    let(:url){ create(:url, expired_at: Time.current) }
    it 'shows expired message' do
      get url.sharing_url
      expect(response).to render_template(:show)
      expect(response.body).to include('expired')
    end
  end

end
