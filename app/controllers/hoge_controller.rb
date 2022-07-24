class HogeController < ApplicationController

  def download
    @post = Post.find(params[:id])
    send_data 'hogehoge',
              :filename => 'hoge.txt',
              :type => 'text/plain',
              :disposition => 'attachment'
  end
end
