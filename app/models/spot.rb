class Spot < ApplicationRecord
  acts_as_mappable

  # :origin から近い順に並び替え
  def self.sort_by_distance(latlng, radius, limit)

    spots = self.within(radius, :origin => latlng).by_distance(:origin => latlng)

    if limit > spots.count
      limit = spots.count
    end

    return spots.limit(limit)
  end

  def self.search(word, limit)
    self.where('address LIKE ?', '%' + word + '%').limit(limit)
  end

end
