module Persistance
  module Relations
    class Statistics < ROM::Relation[:sql]
      schema(:statistics, infer: true)
    end
  end
end
