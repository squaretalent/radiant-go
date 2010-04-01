module MailController
  
  attr_accessor :result
  
  def process_form_with_mail(form, parts, data)
    
    form.results << mail!(form, parts, data) unless parts.config.nil? or parts.config[:mail].nil?
    
    process_form_without_mail(form, parts, data)
    
  end
  
  def mail!(form, parts, data)
    
    mail = Mail.new(form, parts, data)
    
    [%(mail=#{mail.sent? ? "true" : "false"})]
    
  end
  
end