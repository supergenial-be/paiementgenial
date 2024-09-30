class CreateRegistrations < ActiveRecord::Migration[7.2]
  def change
    create_table :registrations do |t|
      t.references :registration_database, null: false, foreign_key: true
      t.string :firstname
      t.string :lastname
      t.string :email
      t.string :phone
      t.string :notion_event_id
      t.integer :amount_cents
      t.string :payment_status
      t.string :status

      t.timestamps
    end
  end
end
