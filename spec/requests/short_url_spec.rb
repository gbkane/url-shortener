require 'rails_helper'

RSpec.describe "ShortUrl requests", type: :request do
  let(:url){ create(:url) }

  it 'redirects to original url' do
    get url.sharing_url
    expect(response).to redirect_to(url.original)
  end

end
