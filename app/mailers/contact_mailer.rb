class ContactMailer < ApplicationMailer
  default from: "example@example.com"   # 問い合わせ者のアドレス
  default to: 'admin@example.com'     # 管理者のアドレス
  layout 'mailer'
  
  def received_email(contact)
    @contact = contact
    mail(from: contact.email, # 問い合わせ者のアドレス
         to: ENV['SEND_MAIL'], # 送信先アドレス(管理者宛)
         subject: 'TTRsiteにお問い合わせがありました。' # メールの件名
    )
  end
  
end
