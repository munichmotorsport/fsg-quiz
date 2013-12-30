json.array!(@quizzes) do |quiz|
  json.extract! quiz, :id, :year, :category, :started_at, :finished
  json.url quiz_url(quiz, format: :json)
end
