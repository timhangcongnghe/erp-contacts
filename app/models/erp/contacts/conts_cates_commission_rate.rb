module Erp::Contacts
  class ContsCatesCommissionRate < ApplicationRecord
    belongs_to :contact, class_name: 'Erp::Contacts::Contact'
    belongs_to :category, class_name: 'Erp::Products::Category'

    # display category_name
    def category_name
      category.present? ? category.name : ''
    end

    def rate=(new_price)
      self[:rate] = new_price.to_s.gsub(/\,/, '')
    end
    def price=(new_price)
      self[:price] = new_price.to_s.gsub(/\,/, '')
    end
  end
end
