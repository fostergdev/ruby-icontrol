class CreateCis < ActiveRecord::Migration[8.0]
  def change
    create_table :cis do |t|
      t.text :content
      t.date :date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
