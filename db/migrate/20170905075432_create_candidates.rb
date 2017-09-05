class CreateCandidates < ActiveRecord::Migration[5.1]
  def change
    create_table :candidates, id: :uuid do |t|
      t.string :code

      t.timestamps
    end
  end
end
