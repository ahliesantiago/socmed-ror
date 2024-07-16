class CreateFollowings < ActiveRecord::Migration[7.1]
  def change
    create_table :followings do |t|
      t.references :user, foreign_key: { to_table: :users }
      t.references :follow, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
