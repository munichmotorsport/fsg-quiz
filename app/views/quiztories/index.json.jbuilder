json.array!(@quiztories) do |quiztory|
  json.extract! quiztory, :id, :finished_at, :failed_submits, :quiz_id
  json.url quiztory_url(quiztory, format: :json)
end
