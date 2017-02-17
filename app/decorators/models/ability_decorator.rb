Erp::Ability.class_eval do
  def contacts_ability(user)
    can :read, Erp::Contacts::Contact
    can :update, Erp::Contacts::Contact do |contact|
      contact.user_id == user.id
    end
  end
end