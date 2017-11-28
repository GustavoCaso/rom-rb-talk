module Persistance
  module Relations
    class CompanyMerges < ROM::Relation[:sql]
      schema(:corporation_merges, infer: true, as: :company_merges)
    end
  end
end
