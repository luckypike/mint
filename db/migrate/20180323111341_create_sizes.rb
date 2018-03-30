class CreateSizes < ActiveRecord::Migration[5.1]
  def change
    create_table :sizes do |t|
      t.string :size
      t.references :sizes_group, foreign_key: true

      t.timestamps
    end
  end
end
