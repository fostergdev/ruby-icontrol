class DropCis < ActiveRecord::Migration[8.0]
  def change
    drop_table :cis
  end
end
