module Erp::Contacts
  class ContactMailer < Erp::ApplicationMailer
    def sending_email_contact(msg)
      @msg = msg
      
      #@todo static emails
      @recipients = ['Hùng Nguyễn <hungnt@hoangkhang.com.vn>']#, 'Luân Phạm <luanpm@hoangkhang.com.vn>', 'Sơn Nguyễn <sonnn@hoangkhang.com.vn>']
      
      send_email(@recipients.join("; "), "Nội dung tin nhắn liên hệ/góp ý từ #{@msg.contact.email}")
    end 
  end
end
