# Playing time task H - write an error_notifier whenever errors raised by controller or model
class ErrorNotifier < ActionMailer::Base
  default from: "Kira <kira@localhost.org>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.error_notifier.error_mailer.subject
  #
  def error_mailer (error)
    @error = error
    mail :to => mail[:from].value, :subject => 'Depot App Error Reporting'  
  end
end
