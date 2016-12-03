module Erp::Contacts
  class Contact < ApplicationRecord
    # class const
    TYPE_PERSON = 'person'
    TYPE_COMPANY = 'company'
    
    def self.get_type_options()
      [
        {text: I18n.t('contacts.contact.individual'),value: self::TYPE_PERSON},
        {text: I18n.t('contacts.contact.company'),value: self::TYPE_COMPANY}
      ]
    end
    
    # Filters
    def self.filter(query, params)
      params = params.to_unsafe_hash
      and_conds = []
      
      #filters
      if params["filters"].present?
        params["filters"].each do |ft|
          or_conds = []
          ft[1].each do |cond|
            or_conds << "#{cond[1]["name"]} = '#{cond[1]["value"]}'"
          end
          and_conds << '('+or_conds.join(' OR ')+')'
        end
      end
      
      #keywords
      if params["keywords"].present?
        params["keywords"].each do |kw|
          or_conds = []
          kw[1].each do |cond|
            or_conds << "LOWER(#{cond[1]["name"]}) LIKE '%#{cond[1]["value"].downcase.strip}%'"
          end
          and_conds << '('+or_conds.join(' OR ')+')'
        end
      end

      query = query.where(and_conds.join(' AND ')) if !and_conds.empty?
      
      return query
    end
    
    def self.search(params)
      query = self.all
      query = self.filter(query, params)
      
      return query
    end
    
  end
end