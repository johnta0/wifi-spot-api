class Spot < ApplicationRecord
  acts_as_mappable

  # :origin から近い順に並び替え
  def self.sort_by_distance(lat, lng, radius)
    self.within(radius, :origin => [lat, lng]).by_distance(:origin => [lat, lng])
  end

end
