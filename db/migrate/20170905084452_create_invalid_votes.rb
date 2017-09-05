class CreateInvalidVotes < ActiveRecord::Migration[5.1]
  def change
    create_table :invalid_votes, id: :uuid do |t|
      t.string :raw
      t.string :reason

      t.timestamps
    end
  end
end
