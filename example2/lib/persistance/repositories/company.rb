module Persistance
  module Repositories
    class Company < ROM::Repository[:company]
      commands :create

    end
  end
end
