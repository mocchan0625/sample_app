class RecipientsController < ApplicationController
  before_action :signed_in_user
  before_action :set_recipient, only: [:edit, :update, :destroy]

  def index
    @recipients = Recipient.order(:name)
  end

  def new
    @recipient = Recipient.new
  end

  def create
    @recipient = Recipient.new(recipient_params)
    if @recipient.save
      flash[:success] = "メール宛先を追加しました"
      redirect_to recipients_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @recipient.update(recipient_params)
      flash[:success] = "メール宛先を更新しました"
      redirect_to recipients_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @recipient.destroy
    flash[:success] = "メール宛先を削除しました"
    redirect_to recipients_path
  end

  private

  def set_recipient
    @recipient = Recipient.find(params[:id])
  end

  def recipient_params
    params.require(:recipient).permit(:name, :email)
  end
end
