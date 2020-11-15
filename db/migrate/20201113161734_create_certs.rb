class CreateCerts < ActiveRecord::Migration[6.0]
  def change
    create_table :certs do |t|
      t.decimal :discount
      t.integer :discount_type
      t.integer :amount
      t.string :code
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
