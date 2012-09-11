module ApplicationHelper
  SITE_NAME = " | LMR.lviv.ua".freeze
  SITE_NAME_LENGTH = SITE_NAME.length.freeze
  SITE_DESCRIPTION = " | LMR.lviv.ua".freeze
  SITE_KEYWORDS = "LMR.lviv.ua".freeze

  def flash_messages
   flash_messages = []
   flash.each do |type, message|
     next if type == :timedout
     next unless message.is_a?(String)
     type = :success if type == :notice
     type = :error   if type == :alert
     text = content_tag(:div, link_to("x", "#", :class => "close", "data-dismiss" => "alert") + message, :class => "alert fade in alert-#{type}")
     flash_messages << text if message
   end
   flash_messages.compact.join("\n").html_safe
  end  

  def w3c_date(date)
    date.utc.strftime("%Y-%m-%dT%H:%M:%S+00:00") if date
  end

  def formatted_date date
    date.strftime("%d/%m/%Y %H:%M") if date
  end

  def yield_or_default(message, default_message = "")
    message.nil? ? default_message : message
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

  def page_part(identifier)
    pp = PagePart[identifier]
    if pp.safe_content?
      pp.content
    else
      pp.content.try :html_safe
    end
  end

  # duplicate method from forem forums_helper because of error undefined methods

  def topics_count(forum)
    if forem_admin_or_moderator?(forum)
      forum.topics.count
    else
      forum.topics.approved.count
    end
  end

  def posts_count(forum)
    if forem_admin_or_moderator?(forum)
      forum.posts.count
    else
      forum.posts.approved.count
    end
  end

  # end of duplicate

  def link_to_page identifier
    page = Page[identifier]
    link_to (page.title.present? ? page.title : page.identifier), page_path(page.identifier)
  end

  def forum_avatar user
    if user
      if user.avatar?
        image_tag(user.avatar.thumb.url)
      else
        image_tag('forem/user_default.png')
      end
    end
  end

  def user_error_messages! user
    return "" if user.errors.empty?

    messages = user.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t("errors.messages.not_saved",
                      :count => user.errors.count,
                      :resource => user.class.model_name.human.downcase)

    html = <<-HTML
    <div id="error_explanation">
      <h2>#{sentence}</h2>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def forum_status user    
    if user
      if user.admin?
        t('forum.admin')
      elsif user.content_manager?
        t('forum.moderator')
      else
        ""
      end
    end
  end

end
