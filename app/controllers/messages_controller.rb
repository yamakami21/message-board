class MessagesController < ApplicationController
  
  # set_messageを:edit, :updateの前に実行する
  before_action :set_message, only: [:edit, :update, :destroy]
  
  def index
    # Messageを全て取得する。
    @messages = Message.all
    @message = Message.new

  end
  
  def create
    # binding.pry
    @message = Message.new(message_params)
    
    if @message.save
      redirect_to root_path , notice: 'メッセージを保存しました'
    else
      # メッセージが保存できなかった時
      @messages = Message.all
      flash.now[:alert] = "メッセージの保存に失敗しました。"
      render 'index'
    end
  end
  
  def edit
  end
  
  def update
    if @message.update(message_params)
      redirect_to root_path , notice: 'メッセージを編集しました'
    else
      # 保存に失敗した場合は編集画面に戻す。
      render 'edit'
    end
  end
  
  def destroy
    @message.destroy
    redirect_to root_path, notice: 'メッセージを削除しました'
  end
  
  private
  def message_params
    params.require(:message).permit(:name, :body)
  end
  
  def set_message
    @message = Message.find(params[:id])
  end
  
end
