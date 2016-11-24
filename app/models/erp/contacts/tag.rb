module Erp::Contacts
  class Tag < ApplicationRecord
    belongs_to :user
  end
end
