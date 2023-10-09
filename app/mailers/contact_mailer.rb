class ContactMailer < ApplicationMailer
  def send_mail(contact, user)
    @contact = contact
    mail to: user.email, bcc: ENV["GMAIL_USERNAME"], subject: "お問い合わせについて【自動送信】"
  end
end
