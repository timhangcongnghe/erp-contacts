Erp::Ability.class_eval do
  def contacts_ability(user)
    can :read, Erp::Contacts::Contact
    
    can :create, Erp::Contacts::Contact do |contact|
      if Erp::Core.available?("ortho_k")
        user.get_permission(:contacts, :contacts, :contacts, :create) == 'yes'
      else
        true
      end
    end
    
    can :update, Erp::Contacts::Contact do |contact|
      true #contact.creator == user
      if Erp::Core.available?("ortho_k")
        !contact.archived? and user.get_permission(:contacts, :contacts, :contacts, :create) == 'yes'
      else
        !contact.archived?
      end
    end
    
    can :archive, Erp::Contacts::Contact do |contact|
      if Erp::Core.available?("ortho_k")
        !contact.archived? and user.get_permission(:contacts, :contacts, :contacts, :archive) == 'yes'
      else
        !contact.archived?
      end
    end
    
    can :unarchive, Erp::Contacts::Contact do |contact|
      if Erp::Core.available?("ortho_k")
        contact.archived? and user.get_permission(:contacts, :contacts, :contacts, :unarchive) == 'yes'
      else
        contact.archived?
      end
    end
    
    can :history_sales_export_list, Erp::Contacts::Contact do |contact|
      if Erp::Core.available?("ortho_k")
        !contact.archived? and user.get_permission(:contacts, :contacts, :contacts, :history_sales_export_list) == 'yes'
      else
        !contact.archived?
      end
    end
    
    can :history_sales_import_list, Erp::Contacts::Contact do |contact|
      if Erp::Core.available?("ortho_k")
        !contact.archived? and user.get_permission(:contacts, :contacts, :contacts, :history_sales_import_list) == 'yes'
      else
        !contact.archived?
      end
    end
    
    can :history_payment_records_list, Erp::Contacts::Contact do |contact|
      if Erp::Core.available?("ortho_k")
        !contact.archived? and user.get_permission(:contacts, :contacts, :contacts, :history_payment_records_list) == 'yes'
      else
        !contact.archived?
      end
    end
    
    can :assign_salesperson, Erp::Contacts::Contact do |contact|
      if Erp::Core.available?("ortho_k")
        user.get_permission(:contacts, :contacts, :contacts, :assign_salesperson) == 'yes'
      else
        true
      end
    end
    
    can :update_sales_price, Erp::Contacts::Contact do |contact|
      if Erp::Core.available?("ortho_k")
        user.get_permission(:contacts, :contacts, :contacts, :update_sales_price) == 'yes'
      else
        true
      end
    end
    
    can :update_purchase_price, Erp::Contacts::Contact do |contact|
      if Erp::Core.available?("ortho_k")
        user.get_permission(:contacts, :contacts, :contacts, :update_purchase_price) == 'yes'
      else
        true
      end
    end
    
    can :update_init_debt, Erp::Contacts::Contact do |contact|
      if Erp::Core.available?("ortho_k")
        user.get_permission(:contacts, :contacts, :contacts, :update_init_debt) == 'yes'
      else
        true
      end
    end
    
    can :conts_cates_commission_rates, Erp::Contacts::Contact do |contact|
      if Erp::Core.available?("ortho_k")
        user.get_permission(:contacts, :contacts, :contacts, :conts_cates_commission_rates) == 'yes'
      else
        true
      end
    end
    
    can :contacts_list_xlsx, :all if (Erp::Core.available?("ortho_k") and user.get_permission(:contacts, :contacts, :contacts, :contacts_list_xlsx) == 'yes')
  end
end
