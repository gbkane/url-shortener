require 'rails_helper'

RSpec.describe ShortUrl, type: :model do

  context 'new url' do
    let(:url) { build(:url) }
    it 'generates a slug' do
      url.save
      expect(url.slug).not_to be_empty
    end
    it 'allows user defined slug' do
      url.slug = 'my-slug'
      url.save
      expect(url.slug).to eq 'my-slug'
      expect(url.sharing_url).to eq "http://test.host/my-slug"
    end
  end

  context 'validations' do
    let!(:url) { create(:url, slug: 'my-slug') }
    it 'validates slug uniqueness' do
      url2 = url.dup
      expect{url2.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end

    it 'validates original presence' do
      url.original = ''
      expect{url.save!}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context '#expires!' do
    let!(:url) { create(:url) }
    it 'expires an acitve url' do
      url.expire!
      expect(url.reload.expired?).to be true
    end

    it 'leaves the expired_at time unchanged' do
      expired_at = 1.week.ago
      url.expired_at = expired_at
      url.save
      url.reload.expire!
      expect(url.reload.expired_at).to eq expired_at
    end
  end
end
