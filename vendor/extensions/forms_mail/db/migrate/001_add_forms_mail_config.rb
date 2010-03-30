class AddFormsMailConfig < ActiveRecord::Migration
  def self.up
    Radiant::Config['mail.pass'] = 'mailpass'
    Radiant::Config['mail.port'] = '587'
    Radiant::Config['mail.smtp'] = 'smtp.gmail.com'
    Radiant::Config['mail.user'] = 'mailer@gmail.com'
  end
end