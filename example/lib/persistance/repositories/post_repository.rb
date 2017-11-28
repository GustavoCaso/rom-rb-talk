module Persistance
  module Repositories
    class PostRepository < ROM::Repository[:posts]
      commands :create

      def overview
        posts.index.to_a
      end

      def create_with_author(author:, title:, body:)
        posts.changeset(:create, {title: title, body: body}).associate(author).commit
      end

      def by_slug!(slug)
        posts.by_slug(slug).one!
      end

      def by_author(author)
        posts.by_author_id(author.id).to_a
      end
    end
  end
end
