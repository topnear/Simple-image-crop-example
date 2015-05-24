class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :image
      t.string :unique_key
      t.integer :ad_id
      t.boolean :is_processed, default: false

      t.timestamps
    end
  end
end
