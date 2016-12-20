module Erp::Contacts
  class Contact < ApplicationRecord
    validates :name, :presence => true
    validates_format_of :email, :allow_blank => true, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => " is invalid (Eg. 'user@domain.com')"
    
    belongs_to :creator, class_name: "Erp::User"
    belongs_to :country, class_name: "Erp::Areas::Country", optional: true
    belongs_to :state, class_name: "Erp::Areas::State", optional: true
    belongs_to :title, optional: true
    
    belongs_to :company, class_name: "Erp::Contacts::Contact", foreign_key: :company_id, optional: true
    has_many :employees, class_name: 'Erp::Contacts::Contact', foreign_key: :company_id
    
    belongs_to :parent, class_name: "Erp::Contacts::Contact", foreign_key: :parent_id, optional: true
    has_many :contacts, class_name: 'Erp::Contacts::Contact', foreign_key: :parent_id
    
    has_and_belongs_to_many :tags
    
    mount_uploader :image_url, Erp::Contacts::ContactUploader
    
    # class const
    TYPE_PERSON = 'person'
    TYPE_COMPANY = 'company'
    TYPE_INVOICE = 'invoice'
    TYPE_SHIPPING = 'shipping'
    TYPE_OTHER = 'other'
    
    # get type options for contact
    def self.get_type_options()
      [
        {text: I18n.t('person'),value: self::TYPE_PERSON},
        {text: I18n.t('company'),value: self::TYPE_COMPANY}
      ]
    end
    
    # get type options for contact contacts
    def self.get_contacts_type_options()
      [
        {text: I18n.t('person'),value: self::TYPE_PERSON},
        {text: I18n.t('invoice'),value: self::TYPE_INVOICE},
        {text: I18n.t('shipping'),value: self::TYPE_SHIPPING},
        {text: I18n.t('other'),value: self::TYPE_OTHER}
      ]
    end
    
    # Filters
    def self.filter(query, params)
      params = params.to_unsafe_hash
      and_conds = []
      
      #filters
      if params["filters"].present?
        params["filters"].each do |ft|
          or_conds = []
          ft[1].each do |cond|
            or_conds << "#{cond[1]["name"]} = '#{cond[1]["value"]}'"
          end
          and_conds << '('+or_conds.join(' OR ')+')'
        end
      end
      
      #keywords
      if params["keywords"].present?
        params["keywords"].each do |kw|
          or_conds = []
          kw[1].each do |cond|
            or_conds << "LOWER(#{cond[1]["name"]}) LIKE '%#{cond[1]["value"].downcase.strip}%'"
          end
          and_conds << '('+or_conds.join(' OR ')+')'
        end
      end

      query = query.where(and_conds.join(' AND ')) if !and_conds.empty?
      
      return query
    end
    
    def self.search(params)
      query = self.all
      query = self.filter(query, params)
      
      # order
      if params[:sort_by].present?
        order = params[:sort_by]
        order += " #{params[:sort_direction]}" if params[:sort_direction].present?
        
        query = query.order(order)
      end
      
      return query
    end
    
    # data for dataselect ajax
    def self.dataselect(keyword='', params='')
      if params[:contact_type].present?
        query = self.where(contact_type: params[:contact_type])
      else
        query = self.all
      end
      
      if keyword.present?
        keyword = keyword.strip.downcase
        query = query.where('LOWER(name) LIKE ?', "%#{keyword}%")
      end
      
      query = query.limit(8).map{|contact| {value: contact.id, text: contact.name} }
    end
    
    # display contact title
    def display_title
      title.present? ? title.display_name : ''
    end
    
    # display contact company
    def display_company
      company.present? ? company.name : ''
    end
    
    # country name
    def country_name
			country.present? ? country.name : ''
		end
    
    # state name
    def state_name
			state.present? ? state.name : ''
		end
    
  end
end