module Erp
  module Contacts
    module ApplicationHelper
      
      #helper /display contact address for contact
      def display_contact_address(contact)
        str = []
        str << contact.address if contact.address?
        str << contact.state_name if contact.state_name.present?
        str << contact.country_name if contact.country_name.present?
        return str.join(", ")
      end
      
    end
  end
end
