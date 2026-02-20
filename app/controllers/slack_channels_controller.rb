class SlackChannelsController < ApplicationController
  before_action :signed_in_user
  before_action :set_slack_channel, only: [:edit, :update, :destroy]

  def index
    @slack_channels = SlackChannel.order(:name)
  end

  def new
    @slack_channel = SlackChannel.new
  end

  def create
    @slack_channel = SlackChannel.new(slack_channel_params)
    if @slack_channel.save
      flash[:success] = "Slackチャンネルを追加しました"
      redirect_to slack_channels_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @slack_channel.update(slack_channel_params)
      flash[:success] = "Slackチャンネルを更新しました"
      redirect_to slack_channels_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @slack_channel.destroy
    flash[:success] = "Slackチャンネルを削除しました"
    redirect_to slack_channels_path
  end

  private

  def set_slack_channel
    @slack_channel = SlackChannel.find(params[:id])
  end

  def slack_channel_params
    params.require(:slack_channel).permit(:name, :webhook_url)
  end
end
