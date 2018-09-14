class ListsController < ApplicationController
  protect_from_forgery with: :null_session

  @@root = '/home/wwwroot/ProxyHostList/lists'

  def list
    render layout: false, content_type: 'text/plain', plain: Dir.entries(@@root).select {|n| n[0] != '.'}.sort.inject(''){|t,n| t + n + "\n"}
  end

  def get
    name = params[:name]
    if not name or name == '' then
      render layout: false, contetn_type: 'text/plain', status: 403, plain: 'Invalid list name'
      return
    end

    begin
      File.open "#{@@root}/#{name}", 'r' do |f|
        render layout: false, content_type: 'text/plain', plain: f.read
      end
    rescue Exception => e
      render layout: false, contetn_type: 'text/plain', status: 404, plain: 'Not Found'
    end
  end

  def set
    name = params[:name]
    body = request.raw_post

    begin
      File.open "#{@@root}/#{name}", File::TRUNC|File::WRONLY do |f|
        f.write body
      end
      render layout: false, content_type: 'text/plain', plain: 'Success'
    rescue
      render layout: false, content_type: 'text/plain', status: 500, plain: 'Failure'
    end
  end
end
