module Persistance
  module Relations
    class Contracts < ROM::Relation[:sql]
      schema(:corporation_contracts, infer: true, as: :contracts) do
        associations do
          belongs_to :company
        end
      end
    end
  end
end
