module Erp::Contacts
  class Title < ApplicationRecord
    belongs_to :user
    
    def self.backend_datatable(params)
      records = self.all.order("created_at DESC")
      
      return records
    end
  end
end
