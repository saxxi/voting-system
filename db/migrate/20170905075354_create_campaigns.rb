class CreateCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :campaigns, id: :uuid do |t|
      t.string :code

      t.timestamps
    end
  end
end
