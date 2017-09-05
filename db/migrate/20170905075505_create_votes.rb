class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes do |t|
      t.boolean :valid
      t.references :candidate, foreign_key: true
      t.references :campaign, foreign_key: true
      t.timestamp :voted_at

      t.timestamps
    end
  end
end
