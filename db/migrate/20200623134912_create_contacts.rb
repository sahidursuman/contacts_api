class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :avatar
      t.text :bio

      t.timestamps
    end
  end
end
