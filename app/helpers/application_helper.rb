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

  def short_date date
    date.strftime("%d.%m.%Y") if date
  end

  def yield_or_default(message, default_message = "")
    message.nil? ? default_message : message
  end

  def inside_layout(layout = 'application', &block) 
    render :inline => capture_haml(&block), :layout => "layouts/#{layout}" 
  end

  def description(t)
    content_for :description do
      t + ", " + SITE_DESCRIPTION
    end
  end  

  def keywords(t)
    content_for :keywords do
      t + ", " + SITE_KEYWORDS
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
    link_to (page.title.present? ? page.title : page.identifier), main_app.page_path(page.identifier)
  end

  def forum_avatar user    
    if user && user.avatar?
      image_tag(user.avatar.thumb.url)
    else
      image_tag('forem/user_default.png')
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

  def connection_error_messages *opts
    messages = []
    opts.each do |opt|
    if opt[:invoice].present?
      messages << alert(I18n.t("errors.messages.connection_failed"))
    end
    if opt[:details].present?
      messages << alert(I18n.t("errors.messages.payment_details_failed"))
    end
    if opt[:payments].present?
      messages << alert(I18n.t("errors.messages.payments_failed"))
    end
  end
  messages.compact.join("\n").html_safe
  end

  def alert msg
    text = content_tag(:div, link_to("x", "#", :class => "close", "data-dismiss" => "alert") + msg, :class => "alert alert-error")
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

  def forum_name user
    if user
      user.forum_name
    else
      t('guest')
    end
  end

  def easypay_path
    if current_user
      "https://easypay.ua/utility/communal-lvov?Account=#{current_user.identifier}"
    else
      "https://easypay.ua/utility/communal-lvov"
    end
  end

  def post_page position
    (position / Forem.per_page).to_i + 1
  end

  def address_error errors, field, message=false
    if message
      # m = errors[field].any? ? errors[field] : errors[:identifier]
      errors[field].first.try(:mb_chars)
    elsif errors[field].any? || errors[:identifier].any?
      'required error'
    end
  end

  def menu_item text, path
    content_tag :li, :class => menu_item_class(path) do
      link_to text, path
    end 
  end

  def menu_item_class path
    'active' if request.path.include?(path)
  end

  def terminal_type payment_terminal
    type  = case payment_terminal.type
            when 'Terminal' then I18n.t("views.payment_types.terminal") 
            when 'LkpDepartment' then I18n.t("views.payment_types.lkp_department") 
            when 'BankDepartment' then I18n.t("views.payment_types.bank_department") 
            else 'Undefined'
            end
  end

  def show_on_map markers
    gmaps({"map_options" => {:auto_adjust => true }, :markers => {:data => markers }})
  end

  def user_address info    
    if info
      divider = info.flat_number.present? ? "/#{info.flat_number}" : ''
      "#{info.street_name} #{info.house_number} #{info.house_letter}#{divider}"
    end
  end

  def counter_month month
    unless month.nil?
      "#{I18n.t('date.month_names')[month.to_i]} (#{month.to_i})"
    end
  end

end