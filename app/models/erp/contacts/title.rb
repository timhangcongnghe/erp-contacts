module Erp::Contacts
  class Title < ApplicationRecord
    belongs_to :user
  end
end
