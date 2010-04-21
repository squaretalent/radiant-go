class FormsMailExtension < Radiant::Extension
  version "0.3"
  description "Provides support for email forms and generic mailing functionality."
  url "http://github.com/squaretalent/radiant-forms_mail-extension"

  define_routes do |map|
    map.resources :mail, :path_prefix => "/pages/:page_id", :controller => "mail"
  end

  extension_config do |config|
    # Force smtp for Action Mailer on the server
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.raise_delivery_errors = true
    ActionMailer::Base.smtp_settings = {
      :enable_starttls_auto => true,
      :address =>           Radiant::Config['mail.smtp'],
      :port =>              Radiant::Config['mail.port'],
      :domain =>            Radiant::Config['mail.smtp'],
      :authentication =>    :plain,
      :user_name =>         Radiant::Config['mail.user'],
      :password =>          Radiant::Config['mail.pass']
    }
  end

  def activate
    FormController.class_eval do
      include FormMailController
      alias_method_chain :process_form, :mail
    end
  end
end