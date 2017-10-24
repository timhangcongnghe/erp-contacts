module Erp
  module Contacts
    module Backend
      class ContsCatesCommissionRatesController < Erp::Backend::BackendController
        
        def form_line
          @conts_cates_commission_rate = ContsCatesCommissionRate.new
          @conts_cates_commission_rate.category_id = params[:add_value]
          
          render partial: params[:partial], locals: {
            conts_cates_commission_rate: @conts_cates_commission_rate,
            uid: helpers.unique_id()
          }          
        end
        
      end
    end
  end
end