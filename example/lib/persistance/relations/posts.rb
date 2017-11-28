module Persistance
  module Relations
    class Posts < ROM::Relation[:sql]
      schema(:posts) do
        attribute :id, Types::Serial
        attribute :author_id, Types::ForeignKey(:authors)
        attribute :title, Types::String
        attribute :body, Types::String
        attribute :published, Types::Bool
        associations do
          belongs_to :author
        end
      end

      def index
        select(
          :id,
          :title,
          authors[:username].as(:author)
        ).
        join(authors)
      end

      def by_id(id)
        where(id: id)
      end

      def by_slug(slug)
        where(slug: slug)
      end

      def published
        where(published: true)
      end
    end
  end
end
