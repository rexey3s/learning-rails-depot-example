# Preview all emails at http://localhost:3000/rails/mailers/error_notifier
class ErrorNotifierPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/error_notifier/error_mailer
  def error_mailer
    ErrorNotifier.error_mailer
  end

end
