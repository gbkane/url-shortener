json.short_urls @short_urls do |url|
  json.extract! url, :id, :original, :slug, :sharing_url, :expired_at
end

json.current_page @short_urls.current_page
json.total_pages @short_urls.total_pages
json.per_page @short_urls.limit_value
