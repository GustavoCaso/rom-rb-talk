module Persistance
  module Relations
    class Geolocations < ROM::Relation[:sql]
      schema(:geolocations, infer: true)
    end
  end
end
