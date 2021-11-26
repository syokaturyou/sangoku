class ContractsController < ApplicationController
  # お問い合わせ機能のため設定
  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    if @contract.save
      ContractMailer.send_mail(@contract).deliver_now
      redirect_to done_path
    else
      render :new
    end
  end

  # メール完了画面
   def done
   end

  private

  def contract_params
    params.require(:contract).permit(:email, :name, :phone_number, :message)
  end

end
