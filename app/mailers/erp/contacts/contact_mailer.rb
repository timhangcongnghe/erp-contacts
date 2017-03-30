module Erp::Contacts
  class ContactMailer < Erp::ApplicationMailer
    def sending_email_contact(msg)
      @msg = msg
      send_email(@msg.to_contact.email, "[TimHangCongNghe.Vn] Bạn có một yêu cầu liên hệ/góp ý cần được xử lý")
    end 
  end
end
