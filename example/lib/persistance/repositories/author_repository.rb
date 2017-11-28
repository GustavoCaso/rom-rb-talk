module Persistance
  module Repositories
    class AuthorRepository < ROM::Repository[:authors]
      commands :create
    end
  end
end
