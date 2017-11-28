module Persistance
  module Relations
    class Articles < ROM::Relation[:sql]
      schema(:corporation_articles, infer: true, as: :articles) do
        associations do
          belongs_to :company
        end
      end

      def not_deleted_order_by_created_at
        not_deleted.order(:created_at)
      end

      def not_deleted
        where(soft_deleted: nil)
      end
    end
  end
end
