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
      ands = []
      #filters
      if params["filters"].present?
        params["filters"].to_unsafe_h.each do |ft|
          ors = []
          ft[1].each do |cond|
            ors << "#{cond[1]["name"]} = #{cond[1]["value"]}"
          end
          ands << '('+ors.join(' OR ')+')'
        end
      end
      query = query.where(ands.join(' AND ')) if !ands.empty?
      
      query
    end
    
    def self.search(params)
      query = self.all
      query = self.filter(query, params)
      
      query
    end
    
  end
end