module Persistance
  module Relations
    class Companies < ROM::Relation[:sql]
      schema(:corporations, as: :companies, infer: true) do
        associations do
          has_one :statistic, foreign_key: :company_id
          has_one :profile, foreign_key: :company_id
          has_one :geolocation, foreign_key: :company_id
          has_one :merge_status, foreign_key: :company_id, relation: :company_merges
          has_one :paying_editor, foreign_key: :company_id, relation: :claimers, view: :paying_editor
          has_many :active_claimers, foreign_key: :company_id, relation: :claimers, view: :active
          has_many :articles, foreign_key: :company_id, view: :not_deleted_order_by_created_at
          has_many :contracts, foreign_key: :company_id
        end
      end

      def for_tag(tag)
        where(tag: tag)
      end

      def for_slug(slug)
        where(slug: slug)
      end

      def for_company_ids(ids)
        where(id: ids)
      end

      def valid
        where(deleted: false)
      end

      def deleted(deleted)
        where(deleted: deleted)
      end

      def published
        where(published: true)
      end

      def public_profile
        where(public_profile: true)
      end

      def public_profiles
        where(public_profile: true)
      end

      def ordered_by_name
        order(:company_name)
      end

      def ordered_by_visits_count
        order(:visits_count).reverse
      end

      def claimed
        where(contract_id: nil).invert
      end

      def for_company_name(company_name)
        where(:company_name.like("#{company_name}"))
      end

      def for_exact_company_name(company_name)
        where { string::upper(corporations[:company_name]).is(company_name.upcase) }.limit(1)
      end

      def having_slaves(boolean)
        if boolean
          where(merged_company_ids: nil).invert
        else
          where(merged_company_ids: nil)
        end
      end
    end
  end
end
