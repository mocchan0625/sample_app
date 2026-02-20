class CreateSlackChannels < ActiveRecord::Migration[7.1]
  def change
    create_table :slack_channels do |t|
      t.string :name, null: false
      t.string :webhook_url, null: false

      t.timestamps
    end
  end
end
