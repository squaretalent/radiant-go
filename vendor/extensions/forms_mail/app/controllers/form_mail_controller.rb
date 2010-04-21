module FormMailController
  
  def process_form_with_mail(form, data, page, response)
    
    result = mail!(form, data, page)
    response.result = response.result.merge(result)
    
    process_form_without_mail(form, data, page, response)
    
  end
  
  def mail!(form, data, page)
    
    unless form.config.nil? or form.config[:mail].nil?
      mail = Mail.new(form, data, page)
      mail.send
    end
    
    result = { :mail => nil }
    unless mail.nil?
      result = {
        :mail => {
          :sent => mail.sent?,
          :message => mail.message,
          :subject => mail.subject,
          :from => mail.from
        }
      }
    end
    result
  end
  
end