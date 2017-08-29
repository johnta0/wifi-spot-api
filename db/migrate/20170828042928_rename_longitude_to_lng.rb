class RenameLongitudeToLng < ActiveRecord::Migration[5.1]
  def change
    rename_column :spots, :longitude, :lng
  end
end
