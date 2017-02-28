Erp::Ability.class_eval do
  def contacts_ability(user)
    can :read, Erp::Contacts::Contact
    can :update, Erp::Contacts::Contact do |contact|
      contact.creator == user
    end
  end
end