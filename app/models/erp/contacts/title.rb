module Erp::Contacts
  class Title < ApplicationRecord
    belongs_to :user
    validates :title, :presence => true
    
    # Filters
    def self.filter(query, params)
      params = params.to_unsafe_hash
      and_conds = []
      
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
      query = self.order("created_at DESC")
      query = self.filter(query, params)
      
      return query
    end
    
    # data for dataselect ajax
    def self.dataselect(keyword='')
      query = self.all
      
      if keyword.present?
        keyword = keyword.strip.downcase
        query = query.where('LOWER(title) LIKE ? OR LOWER(abbreviation) LIKE ?', "%#{keyword}%", "%#{keyword}%")
      end
      
      query = query.limit(15).map{|title| {value: title.id, text: title.display_title} }
    end
    
    def archive
			update_columns(archived: false)
		end
    
    def unarchive
			update_columns(archived: true)
		end
    
    def self.archive_all
			update_all(archived: false)
		end
    
    def self.unarchive_all
			update_all(archived: true)
		end
    
    # display title
    def display_title
			abbreviation.present? ? abbreviation : title
		end
    
  end
end
