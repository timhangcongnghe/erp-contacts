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
  end
end