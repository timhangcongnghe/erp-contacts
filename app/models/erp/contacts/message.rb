module Erp::Contacts
  class Message < ApplicationRecord
    belongs_to :contact, class_name: "Erp::Contacts::Contact"
    belongs_to :to_contact, class_name: "Erp::Contacts::Contact", foreign_key: :to_contact_id
    validates :message, presence: true
  end
end
