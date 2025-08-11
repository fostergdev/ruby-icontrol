class CreateCiEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :ci_entries do |t|
      t.text :content
      t.date :date, null: false
      t.references :ci_month, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
