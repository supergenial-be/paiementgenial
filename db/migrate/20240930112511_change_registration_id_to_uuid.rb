class ChangeRegistrationIdToUuid < ActiveRecord::Migration[7.2]
  def change
    add_column :registrations, :uuid, :uuid, default: "gen_random_uuid()", null: false

    change_table :registrations do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute "ALTER TABLE registrations ADD PRIMARY KEY (id);"
  end
end
