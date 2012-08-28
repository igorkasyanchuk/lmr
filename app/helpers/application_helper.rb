module ApplicationHelper
  SITE_NAME = " | LMR.lviv.ua".freeze
  SITE_NAME_LENGTH = SITE_NAME.length.freeze
  SITE_DESCRIPTION = " | LMR.lviv.ua".freeze
  SITE_KEYWORDS = "LMR.lviv.ua".freeze

  def w3c_date(date)
    date.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00") if date
  end

  def yield_or_default(message, default_message = "")
    message.nil? ? default_message : message
  end
  
  def flash_messages
    messages = []
    %w(notice warning error).each do |msg|
      messages << "<div class='#{msg} flash'>#{html_escape(flash[msg.to_sym])}</div>" unless flash[msg.to_sym].blank?
    end
    flash.clear
    messages.join.html_safe
  end

  def inside_layout(layout = 'application', &block) 
    render :inline => capture_haml(&block), :layout => "layouts/#{layout}" 
  end

  def description(t)
    content_for :description do
      t + " | " + SITE_DESCRIPTION
    end
  end  

  def keywords(t)
    content_for :keywords do
      t + " | " + SITE_KEYWORDS
    end
  end     

  def title(t)
    content_for :title do
      truncate(t, :length => 70 - SITE_NAME_LENGTH, :omission => '') + SITE_NAME
    end
  end

  def include_google_analytics
    render :partial => '/shared/ga' if Rails.env == 'production'
  end
  
  def httpize(url)
    if url && url !~ /http:\/\//
      'http://' + url
    else
      url
    end
  end

  def my_dashboard_path
    if current_user.admin?
      '/admin'
    else
      '/dashboard'
    end
  end
end