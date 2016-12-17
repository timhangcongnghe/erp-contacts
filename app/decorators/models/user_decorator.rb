if Erp::Core.available?("contacts")
  Erp::User.class_eval do
    belongs_to :contact, class_name: "Erp::Contacts::Contact", foreign_key: :contact_id, optional: true
    
    # create contact of user
    after_create :create_user_contact
    
    def create_user_contact
			c = Erp::Contacts::Contact.create(name: self.name,
																				email: self.email,
																				contact_type: Erp::Contacts::Contact::TYPE_PERSON,
																				creator_id: self.creator_id)
			self.update_attributes(contact_id: c.id)
    end
  end
end