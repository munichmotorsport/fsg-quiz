class CreateQuiztories < ActiveRecord::Migration
  def change
    create_table :quiztories do |t|
      t.boolean :finished, :default => false
      t.text :failed_submits
      t.text :answer_values
      t.belongs_to :quiz, index: true

      t.timestamps
    end
  end
end
