module Persistance
  module Relations
    class Users < ROM::Relation[:yaml]
      schema(:users) do
        attribute :name, ROM::Types::String
        attribute :email, ROM::Types::String
        attribute :roles, ROM::Types::Array
      end

      def by_name(name)
        restrict(name: name)
      end
    end
  end
end
