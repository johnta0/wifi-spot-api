class Spot < ApplicationRecord
  acts_as_mappable

  # :origin から近い順に並び替え
  def self.sort_by_distance(latlng, radius)
    self.within(radius, :origin => latlng).by_distance(:origin => latlng)
  end

end
