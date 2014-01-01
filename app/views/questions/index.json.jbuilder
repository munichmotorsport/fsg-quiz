json.array!(@questions) do |question|
  json.extract! question, :id, :content, :answers
  json.url question_url(question, format: :json)
end
