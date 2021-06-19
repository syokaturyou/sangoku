class ContractMailer < ApplicationMailer
   def send_mail(contract)
    @contract = contract
    mail to:   ENV['TOMAIL'], subject: '【我らの三国志】 ' + @contract.name + '様からのお問い合わせ'
   end
end
