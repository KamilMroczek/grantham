json.array!(@signups) do |signup|
  json.extract! signup, :email, :imdb, :linkedin, :photo, :complete
  json.url signup_url(signup, format: :json)
end
