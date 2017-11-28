module Persistance
  module Relations
    class Profiles < ROM::Relation[:sql]
      schema(:profiles, infer: true)
    end
  end
end
