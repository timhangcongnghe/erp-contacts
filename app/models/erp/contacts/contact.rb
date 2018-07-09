module Erp::Contacts
  class Contact < ApplicationRecord
    mount_uploader :image_url, Erp::Contacts::ContactUploader
    validates :name, presence: true
    validates_format_of :email, :allow_blank => true, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, :message => " is invalid (Eg. 'user@domain.com')"

    if Erp::Core.available?("online_store")
      validates :phone, presence: true
    end

    belongs_to :creator, class_name: "Erp::User", optional: true
    belongs_to :user, class_name: "Erp::User", optional: true
    belongs_to :salesperson, class_name: "Erp::User", optional: true
    belongs_to :contact_group, optional: true

    belongs_to :company, class_name: "Erp::Contacts::Contact", foreign_key: :company_id, optional: true
    has_many :employees, class_name: 'Erp::Contacts::Contact', foreign_key: :company_id

    belongs_to :parent, class_name: "Erp::Contacts::Contact", foreign_key: :parent_id, optional: true
    has_many :contacts, class_name: 'Erp::Contacts::Contact', foreign_key: :parent_id

    has_and_belongs_to_many :tags

    has_many :sent_messages, class_name: "Erp::Contacts::Message", dependent: :destroy
    has_many :received_messages, class_name: "Erp::Contacts::Message", foreign_key: :to_contact_id, dependent: :destroy

    MAIN_CONTACT_ID = 1

    def new_account_commission_amount=(new_price)
      self[:new_account_commission_amount] = new_price.to_s.gsub(/\,/, '')
    end

    def init_debt_amount=(new_price)
      self[:init_debt_amount] = new_price.to_s.gsub(/\,/, '')
    end

    def init_supplier_debt_amount=(new_price)
      self[:init_supplier_debt_amount] = new_price.to_s.gsub(/\,/, '')
    end

    if Erp::Core.available?("payments")
      belongs_to :payment_method, class_name: "Erp::Payments::PaymentMethod", optional: true
      belongs_to :payment_term, class_name: "Erp::Payments::PaymentTerm", optional: true

      # payment method name
      def payment_method_name
        payment_method.present? ? payment_method.name : ''
      end

      # payment term name
      def payment_term_name
        payment_term.present? ? payment_term.name : ''
      end
    end

    if Erp::Core.available?("products")
      has_many :conts_cates_commission_rates, dependent: :destroy
      accepts_nested_attributes_for :conts_cates_commission_rates, :reject_if => lambda { |a| a[:category_id].blank? or (a[:rate].blank? and a[:price].blank?) }, :allow_destroy => true
    end

    if Erp::Core.available?("currencies")
      belongs_to :price_term, class_name: "Erp::Currencies::PriceTerm", optional: true

      # price term name
      def price_term_name
        price_term.present? ? price_term.name : ''
      end
    end

    if Erp::Core.available?("areas")
      belongs_to :country, class_name: "Erp::Areas::Country", optional: true
      belongs_to :state, class_name: "Erp::Areas::State", optional: true
      belongs_to :district, class_name: "Erp::Areas::District", optional: true

      # country name
      def country_name
        country.present? ? country.name : ''
      end

      # state name
      def state_name
        state.present? ? state.name : ''
      end
    end

    if Erp::Core.available?("taxes")
      belongs_to :tax, class_name: "Erp::Taxes::Tax", optional: true

      # tax name
      def tax_name
        tax.present? ? tax.name : ''
      end
    end

    # class const
    TYPE_PERSON = 'person'
    TYPE_COMPANY = 'company'
    TYPE_INVOICE = 'invoice'
    TYPE_SHIPPING = 'shipping'
    TYPE_OTHER = 'other'
    GENDER_MALE = 'male'
    GENDER_FEMALE = 'female'

    # get type options for contact
    def self.get_type_options()
      [
        {text: I18n.t('person'),value: self::TYPE_PERSON},
        {text: I18n.t('company'),value: self::TYPE_COMPANY}
      ]
    end

    # get gender for contact
    def self.get_gender_options()
      [
        {text: I18n.t('male'),value: self::GENDER_MALE},
        {text: I18n.t('female'),value: self::GENDER_FEMALE}
      ]
    end

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

      # show archived items condition - default: false
      show_archived = false

      #filters
      if params["filters"].present?
        params["filters"].each do |ft|
          or_conds = []
          ft[1].each do |cond|
            # in case filter is show archived
            if cond[1]["name"] == 'show_archived'
              # show archived items
              show_archived = true
            elsif (cond[1]["name"] != 'in_period_active') && (cond[1]["name"] != 'is_debt_active')
              or_conds << "#{cond[1]["name"]} = '#{cond[1]["value"]}'"
            end
          end
          and_conds << '('+or_conds.join(' OR ')+')' if !or_conds.empty?
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


      # global filter
      global_filter = params[:global_filter]

      if global_filter.present?
				# filter by patient
				if global_filter[:contact_group_id].present?
					query = query.where(contact_group_id: global_filter[:contact_group_id])
				end
				
				if global_filter[:salesperson_id].present?
					query = query.where(salesperson_id: global_filter[:salesperson_id])
				end

			end
      # end// global filter


      # join with users table for search creator
      query = query.joins(:creator)

      ## showing archived items if show_archived is not true
      #query = query.where(archived: false) if show_archived == false

      # add conditions to query
      query = query.where(and_conds.join(' AND ')) if !and_conds.empty?
      
      # single keyword
      if params[:keyword].present?
				keyword = params[:keyword].strip.downcase
				keyword.split(' ').each do |q|
					q = q.strip
					query = query.where('LOWER(erp_contacts_contacts.cache_search) LIKE ?', '%'+q+'%')
				end
			end

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

      query = self.all_active

      if params[:contact_type].present?
        query = query.where(contact_type: params[:contact_type])
      end

      if params[:is_customer].present?
        query = query.where(is_customer: params[:is_customer])
      end

      if params[:is_supplier].present?
        query = query.where(is_supplier: params[:is_supplier])
			end

      if params[:contact_group_id].present?
        query = query.where(contact_group_id: params[:contact_group_id])
			end

      if params[:parent_id].present?
        query = query.where(parent_id: params[:parent_id])
			end
      
      if keyword.present?
				keyword = keyword.strip.downcase
				keyword.split(' ').each do |q|
					q = q.strip
					query = query.where('LOWER(erp_contacts_contacts.cache_search) LIKE ?', '%'+q+'%')
				end
			end

      if params[:contact_id].present?
        query = query.where.not(id: params[:contact_id])
      end

      query = query.limit(25).map{|contact| {value: contact.id, text: contact.contact_name} }
    end

    # contact name
    def contact_name
      return name
    end

    # staff name
    def staff_name
			user.present? ? user.name : ''
		end

    # salesperson name
    def salesperson_name
			salesperson.present? ? salesperson.name : ''
		end

    # contact group name
    def contact_group_name
			contact_group.present? ? contact_group.name : ''
		end
    
    # contact group code
    def contact_group_code
			contact_group.present? ? contact_group.code : nil
		end

    # contact district name
    def district_name
      district.present? ? district.name : ''
    end

    # contact state name
    def state_name
      state.present? ? state.name : ''
    end

    # contact birthday
    def contact_birthday
			birthday.present? ? birthday : nil
		end

    def archive
			update_attributes(archived: true)
		end

    def unarchive
			update_attributes(archived: false)
		end

    def self.archive_all
			update_all(archived: true)
		end
    
    def self.all_active
			self.where(archived: false)
		end

    def self.unarchive_all
			update_all(archived: false)
		end

    # Get main contact
    def self.get_main_contact
      #@todo: hard code
      return Contact.find(self::MAIN_CONTACT_ID)
    end
    
    # force generate code
    after_create :generate_code
    def generate_code
      # group code
      group_code = self.contact_group_code
      group_code = 'LH' if !group_code.present?
      
      query = Erp::Contacts::Contact.where(contact_group_id: self.contact_group_id)
      
      num = query.where('created_at <= ?', self.created_at).count

      self.code = "#{group_code}-#{num.to_s.rjust(4, '0')}"
      self.save
		end
    
    # Update cache search
    after_save :update_cache_search
		def update_cache_search
			str = []
			str << code.to_s.downcase.strip
			str << name.to_s.downcase.strip
			str << phone.to_s.downcase.strip if phone.present?
			str << email.to_s.downcase.strip if email.present?
			#str << address.to_s.downcase.strip if address.present?
			#str << district_name.to_s.downcase.strip if district.present?
			#str << state_name.to_s.downcase.strip if state.present?

			self.update_column(:cache_search, str.join(" ") + " " + str.join(" ").to_ascii)
		end

    validate :must_select_is_customer_or_supplier
    def must_select_is_customer_or_supplier
      errors.add(:is_customer, :message_must_select) if (is_customer != true and is_supplier != true and user_id.nil?)
    end

    # get customer commission rate by product
    def get_customer_commission_rate_by_product(product)
      # @todo re-update this function
      cat_ids = [product.category_id]
      cat_ids << product.category.parent_id if product.category.present? and product.category.parent_id.present?
      query = self.conts_cates_commission_rates.where(category_id: cat_ids).last
      if query.present?
        return query
      else
        return nil
      end
    end

    def parent_code
      parent.nil? ? '' : parent.code
    end

    def parent_name
      parent.nil? ? '' : parent.name
    end

  end
end
