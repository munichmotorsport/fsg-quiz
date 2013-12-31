class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.integer :year
      t.string :category
      t.time :started_at
      t.time :last_submit
      t.boolean :finished

      t.timestamps
    end
  end
end
