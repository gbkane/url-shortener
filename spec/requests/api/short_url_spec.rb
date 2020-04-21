require 'rails_helper'

RSpec.describe "ShortUrl API requests", type: :request do

  context 'GET' do
    let!(:url){ create(:url, slug: 'my-slug') }
    let(:url2){ create(:url, slug: 'other-slug') }

    it 'returns list of urls' do
      url2
      get api_short_urls_path
      json_response = JSON.parse(response.body)
      expect(json_response['short_urls'].size).to eq 2
      expect(response.body).to include("http://test.host/my-slug")
      expect(response.body).to include("http://test.host/other-slug")
    end

    it 'returns the resource' do
      get api_short_url_path(url)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("http://test.host/my-slug")
    end
  end

  context 'POST' do
    it 'generates a sharing url' do
      post api_short_urls_path,
        params: {
          short_url: {original: 'http://fakeurl.com', slug: 'my-slug'}
        }
      expect(response).to have_http_status(:created)
      expect(response).to render_template(:show)
      expect(response.body).to include("http://test.host/my-slug")
    end
    context 'invalid slug' do
      let!(:url){ create(:url, slug: 'my-slug') }
      it 'is unprocessable' do
        post api_short_urls_path,
          params: {
            short_url: {original: 'http://fakeurl.com', slug: 'my-slug'}
          }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to_not render_template(:show)
        expect(response.body).to include("Slug has already been taken")
      end
    end
  end

  context 'PATCH' do
    let!(:url){ create(:url, slug: 'my-slug') }
    it 'can update the resource' do
      patch api_short_url_path(url),
        params: {
          short_url: {original: 'http://other-fakeurl.com', slug: 'other-slug'}
        }
      expect(response).to render_template(:show)
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('other-slug')
    end

    context 'expiring url' do
      it 'can expire via update' do
        patch api_short_url_path(url), params: {short_url:{expired_at: '2020-04-20'}}
        json_response = JSON.parse(response.body)
        expect(response).to render_template(:show)
        expect(json_response['expired_at'].to_s).to include('2020-04-20')
      end
      it 'can call expire' do
        patch expire_api_short_url_path(url)
        json_response = JSON.parse(response.body)
        expect(response).to render_template(:show)
        expect(json_response['expired_at']).to be_present
      end
    end

    context 'invalid slug' do
      let!(:url2){ create(:url, slug: 'other-slug') }
      it 'is unprocessable' do
        patch api_short_url_path(url),
          params: {
            short_url: {slug: 'other-slug'}
          }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response).to_not render_template(:show)
        expect(response.body).to include("Slug has already been taken")
      end
    end
  end

  context 'DELETE' do
    let!(:url){ create(:url, slug: 'my-slug') }
    it 'deletes the resource' do
      delete api_short_url_path(url)
      expect(response).to have_http_status(:no_content)
    end
  end
end
