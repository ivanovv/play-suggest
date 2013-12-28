json.array!(@keywords) do |keyword|
  json.extract! keyword, :id, :value
  json.url keyword_url(keyword, format: :json)
end
