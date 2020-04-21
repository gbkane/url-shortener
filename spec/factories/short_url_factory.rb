FactoryBot.define do
  factory :url, class: ShortUrl do
    original {'http://fakeurl.com'}
  end
end
