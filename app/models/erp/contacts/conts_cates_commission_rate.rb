module Erp::Contacts
  class ContsCatesCommissionRate < ApplicationRecord
    belongs_to :contact, class_name: 'Erp::Contacts::Contact'
    belongs_to :category, class_name: 'Erp::Products::Category'
    
    # display category_name
    def category_name
      category.present? ? category.name : ''
    end
  end
end
