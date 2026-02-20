class CreateRecipients < ActiveRecord::Migration[7.1]
  def change
    create_table :recipients do |t|
      t.string :name, null: false
      t.string :email, null: false

      t.timestamps
    end
    add_index :recipients, :email, unique: true
  end
end
