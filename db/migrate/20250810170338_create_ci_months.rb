class CreateCiMonths < ActiveRecord::Migration[8.0]
  def change
    create_table :ci_months do |t|
      t.integer :month, null: false
      t.integer :year, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :ci_months, [ :user_id, :month, :year ], unique: true
  end
end
