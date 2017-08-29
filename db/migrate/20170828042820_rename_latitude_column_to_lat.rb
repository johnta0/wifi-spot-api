class RenameLatitudeColumnToLat < ActiveRecord::Migration[5.1]
  def change
    rename_column :spots, :latitude, :lat
  end
end
