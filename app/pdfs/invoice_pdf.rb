# encoding: utf-8
require "prawn/measurement_extensions"
class InvoicePdf < Prawn::Document
  def initialize(invoice, view, date, user_info)
    super(
      page_layout: :portrait,
      top_margin: 1.5.cm,
      right_margin: 1.5.cm,
      bottom_margin: 1.5.cm,
      left_margin: 1.5.cm,
      page_size: 'A4'
    )
    @invoice = invoice
    @view = view
    @user_info = user_info
    font_families.update("DejaVuSans" => {:normal => "#{Rails.root}/app/assets/fonts/DejaVuSans.ttf", :bold => "#{Rails.root}/app/assets/fonts/DejaVuSans-Bold.ttf"})
    font "DejaVuSans"
    lmr_info date
    user_information
    line_items
  end
  
  def lmr_info date
    font_size 10.pt
    text "Звіт по комунальних послугах за #{I18n.t("date.month_names")[date.month]} #{date.year} року", :style => :bold
    stroke_horizontal_rule
    move_down 1.cm    
  end  

  def user_information
    font_size = 9.pt
    data = [["ПІБ:", @user_info.pib,"Адреса:", user_address(@user_info)],
            ["№ особового рахунку:", @user_info.consumer_code,"Кількість мешканців:", "#{@user_info.people_count} ос."],
            ["","","Розрахункова площа:", "#{@user_info.calc_area} кв.м."],
            ["","","Опалювальна площа:", "#{@user_info.heat_area} кв.м."]]
    table data do
      self.cell_style = {:borders => [],
        :width => 4.5.cm, :height => 0.7.cm}
    end
    move_down 1.cm
  end
  
  def line_items
    move_down 20
    font_size 8    
    table line_item_rows do
      self.cell_style = {:border_width => 0.5, :border_color => "999999", :height => 0.6.cm}
      self.width = 18.cm      
      row(0).background_color = "999999"
      row(-1).font_style = :bold
      columns(1..7).align = :center
      position = :center
      self.row_colors = ["EEEEEE", "FFFFFF"]
      self.header = true
    end
  end

  def line_item_rows
    [["Послуга", "Борг", "Нараховано", "Корегування", "Пільги", "Субсидії", "Оплачено", "Сальдо"]] +
    services_body + 
    [['Разом', @invoice.total.borg, @invoice.total.invoice, @invoice.total.correction, @invoice.total.pilga, @invoice.total.subsidy, @invoice.total.pay, @invoice.total.saldo]]
  end

  def services_body
    services = []
    @invoice.services.each do |s|
      services << [s.name, s.borg, s.invoice, s.correction, s.pilga, s.subsidy, s.pay, s.saldo]
      if s.sub_services.any?
        s.sub_services.each do |ss|
          services << [" - #{ss.name}", ss.borg, ss.invoice, ss.correction, ss.pilga, ss.subsidy, ss.pay, ss.saldo]
        end
      end
    end
    services
  end
  
  # def price(num)
  #   @view.number_to_currency(num)
  # end
  
  def total_price
    move_down 15
    text "Total Price: 10000", size: 10, style: :bold
  end

  def user_address info    
    if info
      divider = info.flat_number.present? ? "/#{info.flat_number}" : ''
      "#{info.street_name} #{info.house_number} #{info.house_letter}#{divider}"
    end
  end


end