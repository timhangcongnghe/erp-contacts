module Erp::Contacts
  class Title < ApplicationRecord
    belongs_to :user
    
    def self.backend_datatable(params)
      records = self.all.order("created_at DESC")
      
      return records
    end
    
    # data for dataselect ajax
    def self.dataselect(keyword='')
      query = self.all
      
      if keyword.present?
        keyword = keyword.strip.downcase
        query = query.where('LOWER(title) LIKE ?', "%#{keyword}%")
      end
      
      query = query.limit(15).map{|title| {value: title.id, text: title.title} }
    end
  end
end
