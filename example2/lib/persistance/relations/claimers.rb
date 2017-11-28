module Persistance
  module Relations
    class Claimers < ROM::Relation[:sql]
      PAYING_EDITOR = 4
      schema(:corporation_claimers, infer: true, as: :claimers) do
        associations do
          belongs_to :company
        end
      end

      def active
        where(active: true)
      end

      def paying_editor
        where(active: true, roles: PAYING_EDITOR)
      end
    end
  end
end
