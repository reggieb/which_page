json.array!(@source_pages) do |source_page|
  json.extract! source_page, :id, :url
  json.url source_page_url(source_page, format: :json)
end
