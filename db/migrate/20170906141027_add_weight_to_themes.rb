class AddWeightToThemes < ActiveRecord::Migration[5.1]
  def change
    add_column :themes, :weight, :integer, default: 0
  end
end
