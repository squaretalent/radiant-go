class Mail
  attr_reader :page, :config, :data, :errors

  def initialize(form, parts, data)
    @form, @data, @config = form, data, parts.config[:mail]

    @body = data[:page].render_snippet(parts)
  end
  
  def from
    @data[@config[:from_field]] || @config[:from]
  end

  def recipients
    @config[:recipients]
  end

  def reply_to
    @data[@config[:reply_to_field]] || from
  end

  def sender
    @data[@config[:sender_field]] || @config[:sender]
  end

  def subject
    @data[@config[:subject_field]] || @config[:subject]
  end
  
  def cc
    @config[:cc]
  end
  
  def files
    res = []
    data.each_value do |d|
      res << d if StringIO === d or Tempfile === d
    end
    res
  end
  
  def filesize_limit
    config[:filesize_limit] || 0
  end
  
  def headers
    @headers = { 'Reply-To' => reply_to }
    if sender
      @headers['Return-Path'] = sender
      @headers['Sender'] = sender
    end
  end

  def send

    Mailer.deliver_generic_mail(
      :recipients => recipients,
      :from => from,
      :subject => subject,
      :body => @body,
      :cc => cc,
      :headers => headers,
      :files => files,
      :filesize_limit => filesize_limit
    )
    @sent = true
  rescue Exception => exception
    puts exception.inspect
    @sent = false
  end

  def sent?
    @sent
  end
end