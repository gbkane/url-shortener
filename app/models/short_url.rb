class ShortUrl < ActiveRecord::Base
  BASE_SIZE = 12.freeze
  MAX_SLUG_TRIES = 5.freeze
  validates :original, :slug, presence: true
  validates :slug, uniqueness: true

  before_validation :generate_random_slug, if: Proc.new{|u| u.slug.blank?}

  def sharing_url
    "#{ENV['PROTOCOL']}://#{ENV['HOST']}/#{slug}"
  end

  def expire!
    return true if expired?
    self.expired_at = Time.current
    save!
  end

  def expired?
    expired_at.present?
  end

  private

  def generate_random_slug
    base_size = BASE_SIZE
    self.slug = SecureRandom.urlsafe_base64(base_size)
    ctr = 0
    while ShortUrl.where(slug: self.slug).exists? do
      base_size += 1 if ctr > MAX_SLUG_TRIES
      self.slug = SecureRandom.urlsafe_base64(base_size)
      ctr += 1
    end
  end
end
