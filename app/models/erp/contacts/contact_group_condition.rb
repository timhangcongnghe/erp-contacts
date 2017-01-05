module Erp::Contacts
  class ContactGroupCondition < ApplicationRecord
    belongs_to :contact_group, optional: true
    
    CONDITION_TOTAL_REVENUE = 'total_revenue'
    CONDITION_TOTAL_INVOICED = 'total_invoiced'
    CONDITION_REWARD_POINT = 'reward_point'
    CONDITION_TOTAL_POINT = 'total_point'
    CONDITION_PURCHASE_DATE = 'purchase_date'
    CONDITION_PURCHASE_NUMBER = 'purchase_number'
    CONDITION_DEBT = 'debt'
    CONDITION_BIRTHDAY = 'birthday'
    CONDITION_AGE = 'age'
    CONDITION_GENDER = 'gender'
    OPERATOR_GREATER_THAN = 'greater_than'
    OPERATER_LESS_THAN = 'less_than'
    OPERATER_EQUALS = 'equals'
    OPERATOR_GREATER_THAN_OR_EQUAL_TO = 'greater_than_or_equal_to'
    OPERATOR_LESS_THAN_OR_EQUAL_TO = 'less_than_or_equal_to'
    
    # get contact group conditions
    def self.get_contact_group_condition_name_options()
      [
        {text: I18n.t(self::CONDITION_TOTAL_REVENUE),value: self::CONDITION_TOTAL_REVENUE},
        {text: I18n.t(self::CONDITION_TOTAL_INVOICED),value: self::CONDITION_TOTAL_INVOICED},
        {text: I18n.t(self::CONDITION_REWARD_POINT),value: self::CONDITION_REWARD_POINT},
        {text: I18n.t(self::CONDITION_TOTAL_POINT),value: self::CONDITION_TOTAL_POINT},
        {text: I18n.t(self::CONDITION_PURCHASE_DATE),value: self::CONDITION_PURCHASE_DATE},
        {text: I18n.t(self::CONDITION_PURCHASE_NUMBER),value: self::CONDITION_PURCHASE_NUMBER},
        {text: I18n.t(self::CONDITION_DEBT),value: self::CONDITION_DEBT},
        {text: I18n.t(self::CONDITION_BIRTHDAY),value: self::CONDITION_BIRTHDAY},
        {text: I18n.t(self::CONDITION_AGE),value: self::CONDITION_AGE},
        {text: I18n.t(self::CONDITION_GENDER),value: self::CONDITION_GENDER}
      ]
    end
    
    # get contact group conditions
    def self.get_contact_group_condition_operator_options()
      [
        {text: I18n.t(self::OPERATOR_GREATER_THAN),value: self::OPERATOR_GREATER_THAN},
        {text: I18n.t(self::OPERATER_LESS_THAN),value: self::OPERATER_LESS_THAN},
        {text: I18n.t(self::OPERATER_EQUALS),value: self::OPERATER_EQUALS},
        {text: I18n.t(self::OPERATOR_GREATER_THAN_OR_EQUAL_TO),value: self::OPERATOR_GREATER_THAN_OR_EQUAL_TO},
        {text: I18n.t(self::OPERATOR_LESS_THAN_OR_EQUAL_TO),value: self::OPERATOR_LESS_THAN_OR_EQUAL_TO}
      ]
    end
  end
end
