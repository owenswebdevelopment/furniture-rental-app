class CreateRentals < ActiveRecord::Migration[7.1]
  def change
    create_table :rentals do |t|
      t.date :start_date
      t.date :end_date
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.references :furniture, null: false, foreign_key: true

      t.timestamps
    end
  end
end
