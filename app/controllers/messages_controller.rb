class MessagesController < ApplicationController
  before_action :signed_in_user
  before_action :set_message, only: [:show, :edit, :update, :destroy, :broadcast]

  def index
    @sent_messages  = Message.sent
    @draft_messages = Message.drafts
  end

  def show
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user

    if @message.save
      flash[:success] = "メッセージを保存しました"
      redirect_to @message
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      flash[:success] = "メッセージを更新しました"
      redirect_to @message
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @message.destroy
    flash[:success] = "メッセージを削除しました"
    redirect_to messages_path
  end

  def broadcast
    if @message.sent?
      flash[:warning] = "このメッセージはすでに送信済みです"
      redirect_to @message
      return
    end

    recipients_count    = Recipient.count
    slack_channels_count = SlackChannel.count

    if recipients_count == 0 && slack_channels_count == 0
      flash[:warning] = "送信先が登録されていません。メール宛先またはSlackチャンネルを先に登録してください"
      redirect_to @message
      return
    end

    @message.broadcast!(MessageMailer, SlackService.new)

    flash[:success] = "メッセージを送信しました（メール: #{recipients_count}件、Slack: #{slack_channels_count}チャンネル）"
    redirect_to @message
  rescue => e
    Rails.logger.error "[MessagesController#broadcast] #{e.message}"
    flash[:danger] = "送信中にエラーが発生しました: #{e.message}"
    redirect_to @message
  end

  private

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:subject, :body)
  end
end
