class AddTeamToUser < ActiveRecord::Migration
  def change
    add_column :users, :team, :string
  end
end
