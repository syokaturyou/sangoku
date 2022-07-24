class HogeController < ApplicationController

  def download
    send_data 'hogehoge',
              :filename => 'hoge.txt',
              :type => 'text/plain',
              :disposition => 'attachment'
  end

  # def download
  #   filepath = Rails.root.join('app', 'pdfs', 'hoge.pdf')
  #   stat = File::stat(filepath)
  #   send_file(filepath, :filename => 'hoge.pdf', :length => stat.size)
  # end

end