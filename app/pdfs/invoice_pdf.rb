# encoding: utf-8
require "prawn/measurement_extensions"
class InvoicePdf < Prawn::Document
  include ApplicationHelper
  
  def initialize(invoice, view, date, user_info, counters, details)
    super(
      page_layout: :portrait,
      top_margin: 1.5.cm,
      right_margin: 1.5.cm,
      bottom_margin: 1.5.cm,
      left_margin: 1.5.cm,
      page_size: 'A4'
    )
    @counters = counters
    @details = details
    @invoice = invoice
    @view = view
    @user_info = user_info
    @date = date
    font_families.update("DejaVuSans" => {:normal => "#{Rails.root}/app/assets/fonts/DejaVuSans.ttf", :bold => "#{Rails.root}/app/assets/fonts/DejaVuSans-Bold.ttf"})
    font "DejaVuSans"
    group_by_service_providers
  end

  def group_by_service_providers
    services_providers = @user_info.service_providers.group_by{|sp| sp.service_provider_code}
    services_providers.each_with_index do |(code, services), index|
      lmr_info(@date, services.first)
      user_information
      codes = services.map{|s| s.service_code}
      line_items codes
      house_maintanance if codes.include?('1')
      draw_counters codes
      move_down 0.5.cm
      cold_water if codes.include?('2')
      hot_cold_water if codes.include?('2') || codes.include?('3')
      start_new_page if index != (services_providers.size - 1)
    end
  end
  
  def lmr_info date, sp
    font_size 10.pt
    text "Дата друку: #{Time.now.strftime('%d/%m/%y %H:%M:%S')}"
    address = ServiceProvider.find_by_code(sp.service_provider_code).try(:address)
    address_name = ", #{address}" if address
    text "#{sp.service_provider_name} #{address_name}"
    move_down 0.5.cm
    text "ПОВІДОМЛЕННЯ НА ОПЛАТУ ЖИТЛОВО-КОМУНАЛЬНИХ ПОСЛУГ за #{I18n.t("date.month_names")[date.month]} #{date.year} року"
    stroke_horizontal_rule
    # move_down 1.cm
  end  

  def user_information
    font_size = 8.pt
    data = [["Кількість мешканців:", "#{@user_info.people_count} ос.", "Адреса:", user_address(@user_info)],
            ["Загальна площа:", "#{@user_info.calc_area} кв.м.", "Особовий рахунок:", @user_info.consumer_code],
            ["Опалювальна площа:", "#{@user_info.heat_area} кв.м.", "ПІП:", @user_info.pib],
            ["Спожито: ","#{central_heating.decode(:consumed, '14')} ГКал.","Вартість ГКал\n(в опал. сезон):", "#{central_heating.decode(:tariff, '14')} грн."]]
    table data do
      self.cell_style = {:borders => [], :width => 4.5.cm}
    end
  end

  def draw_counters codes
    move_down 1.cm    
    font_size = 10.pt
    if counters_data(codes)
      table counters_data(codes) do
        self.cell_style = {:borders => []}
      end
    end
  end

  def counters_data codes
    counters = []
    codes.each do |code|
      @counters.select{ |c| c.type_code == code }.each do |c|
        stroke_horizontal_rule
        counters << [c.state_number, c.type_name, '', c.end_state, '', '']
      end
    end
    if counters.any?
      [["Державний номер", "Вид лічильника", "Поч. покази", 'Кінц. покази', "Кількість", "Корекція"]] + counters
    else
      false
    end
  end
  
  def line_items codes
    move_down 20
    font_size 7    
    table line_item_rows(codes) do
      self.cell_style = {:border_width => 0.5, :border_color => "999999", :height => 0.6.cm}
      self.width = 18.cm      
      row(0).background_color = "999999"
      row(-1).font_style = :bold
      row(-1).background_color = "FFFFFF"
      columns(1..7).align = :center
      position = :center
      self.row_colors = ["EEEEEE", "FFFFFF"]
      self.header = true
    end
  end

  def line_item_rows codes
    [["Вид платежу", "Борг", "Оплачено", 'Тариф', "Нараховано", "Пільга", "Субсидія", "Коректура", "До сплати"]] +
    services_body(codes)
  end

  def services_body codes
    services = []
    codes.each do |code|
      s = @invoice.services.select{|s| s.service_code == code}.first
      services << [s.name, s.borg, s.pay, '', s.invoice, s.pilga, s.subsidy, s.correction, s.saldo]
      if s.sub_services.any?
        s.sub_services.each do |ss|
          services << [" - #{ss.name}", '', '', '', ss.invoice, '', '', '', '']
        end
      end
    end
    total = services.transpose
    total[-1] = total[-1].map{|s| s.nil? ? 0 : BigDecimal(s)}.sum
    services << [{:content => 'Разом до сплати', :colspan => 8, :align => :right},  total[-1]]
    services
  end

  def cold_water
    text "УВАГА СПЛАТА ЗА СПОЖИТИЙ ОБЄ'М ХОЛОДНОЇ ВОДИ ЗДІЙСНЮЄТЬСЯ ЗА ПОВІДОМЛЕННЯМ ЛКП"
  end

  def hot_cold_water
    text "<< Показники лічильників холодної та гарячої води подавати в період з 25 по 30 число кожного місяця за номером тел. >>"
    stroke_horizontal_rule
  end

  def central_heating
    @details.services.find{|x| x.service_code == '4' }
  end

  def house_maintanance
    exp_data = []
    expenses = @details.services.find{|x| x.service_code == '1'}.expenses
    expenses.each_slice(2) do |exps|
      exp_data << [exps[0].try(:name), exps[0].try(:sum), exps[1].try(:name), exps[1].try(:sum)]
    end
    if exp_data.any?
      move_down 0.5.cm
      stroke_horizontal_rule
      table exp_data do
        self.cell_style = {:borders => []}
      end
      move_down 0.5.cm
    end
  end
  
  def total_price
    move_down 15
    text "Total Price: 10000", size: 10, style: :bold
  end


end