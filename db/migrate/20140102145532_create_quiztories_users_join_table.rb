class CreateQuiztoriesUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :quiztories_users, id: false do |t|
      t.belongs_to :quiztory, index: true
      t.belongs_to :user, index: true
    end
  end
end
