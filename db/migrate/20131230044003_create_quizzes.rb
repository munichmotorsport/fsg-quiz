class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.integer :season
      t.string :category
      t.boolean :production_ready, :default => false

      t.timestamps
    end
  end
end
