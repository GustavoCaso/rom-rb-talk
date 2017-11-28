module Persistance
  module Relations
    class Authors < ROM::Relation[:sql]
      schema(:authors) do
        attribute :id, Types::Serial
        attribute :email, Types::String
        attribute :username, Types::String
        associations do
          has_many :posts
        end
      end

      def by_id(id)
        where(id: id)
      end
    end
  end
end
