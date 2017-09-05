class CreateVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :votes, id: :uuid do |t|
      t.boolean :is_valid
      t.references :candidate, foreign_key: true, type: :uuid, null: false
      t.references :campaign, foreign_key: true, type: :uuid, null: false
      t.timestamp :voted_at

      t.timestamps
    end
  end
end
