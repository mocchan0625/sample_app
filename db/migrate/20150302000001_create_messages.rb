class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.string  :subject, null: false
      t.text    :body, null: false
      t.integer :user_id
      t.datetime :sent_at

      t.timestamps
    end
    add_index :messages, :user_id
  end
end
