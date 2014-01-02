class CreateQuiztories < ActiveRecord::Migration
  def change
    create_table :quiztories do |t|
      t.time :finished_at
      t.text :failed_submits
      t.belongs_to :quiz, index: true

      t.timestamps
    end
  end
end
