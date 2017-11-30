module Erp
  module Contacts
    module ApplicationHelper

      #helper /display contact address for contact
      def display_contact_address(contact)
        str = []
        str << contact.address if contact.address?
        str << contact.district_name if contact.district_name.present?
        str << contact.state_name if contact.state_name.present?
        #str << contact.country_name if contact.country_name.present?
        return str.join(", ")
      end

      # contact link helper
      def contact_link(contact, text=nil)
        text = text.nil? ? contact.name : text
        raw "<a href='#{erp_contacts.backend_contact_path(contact)}' class='modal-link'>#{text}</a>"
      end

    end
  end
end
