module Operations
  class ExtractCompaniesWithoutContracts
    def initailize(company_repository)
      @company_repository = company_repository
    end

    def call(user)

    end
  end
end

def self.companies_without_contracts(user)
      return [] if user.occupation_type == 'student' || user.occupation_type == 'retired'
      possible_companies = []
      current_company = user.current_company.is_current == '0' || user.current_company.end_date.present? || user.current_company.tag.blank? ? [] : [user.current_company]
      user_companies = user.additional_companies.select{ |company| company.tag.present? }
      user_companies = current_company + user_companies

      user_companies.each do |old_company|
        company = nil
        company = find_by_tag(old_company.tag) || new({ :tag => old_company.tag, :company_name => old_company.name }, :without_protection => true)

        # We can request a contract for deleted company. These companies doesn't have company_name and profile information and statistics neither.
        # We have to fill it out again with the info provided from the user profile.
        if company.deleted
          company.build_statistic
          company.company_name     = old_company.name if company.company_name.blank?
          company.employees_type_1 = 1 if company.employees_type_1.blank?
          company.save!
          company.add_employee(user.id) unless company.is_employee?(user.id)
        end

        possible_companies << company if company && !company.has_valid_contract? && !company.is_merged?
      end

      possible_companies.delete_if { |company| !company.published }
    end
