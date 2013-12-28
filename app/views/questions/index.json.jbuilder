json.array!(@questions) do |question|
  json.extract! question, :id, :content, :year, :category, :answers
  json.url question_url(question, format: :json)
end
