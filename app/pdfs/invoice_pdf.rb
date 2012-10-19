# encoding: utf-8
require "prawn/measurement_extensions"
class InvoicePdf < Prawn::Document
  def initialize(invoice, view, date)
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
    font_families.update("DejaVuSans" => {:normal => "#{Rails.root}/app/assets/fonts/DejaVuSans.ttf", :bold => "#{Rails.root}/app/assets/fonts/DejaVuSans-Bold.ttf"})
    font "DejaVuSans"
    lmr_info date
    user_info
    line_items
  end
  
  def lmr_info date
    font_size 10.pt
    text "Звіт по комунальних послугах за #{I18n.t("date.month_names")[date.month]} #{date.year} року", :style => :bold
    stroke_horizontal_rule
    move_down 1.cm    
  end  

  def user_info
    font_size = 9.pt
    data = [["ПІБ:","Петренко П. П.","Адреса:","Роксоляни 2/5"],
            ["№ особового рахунку:","4070000646163","Кількість мешканців:","3 особи"],
            ["","","Розрахункова площа:","89,1 кв.м."],
            ["","","Опалювальна площа:","89,1 кв.м."]]
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
    @invoice.services.map do |s|
      [s.name, s.borg, s.invoice, s.correction, s.pilga, s.subsidy, s.pay, s.saldo]
    end + 
    [['Разом', @invoice.total.borg, @invoice.total.invoice, @invoice.total.correction, @invoice.total.pilga, @invoice.total.subsidy, @invoice.total.pay, @invoice.total.saldo]]
  end
  
  # def price(num)
  #   @view.number_to_currency(num)
  # end
  
  def total_price
    move_down 15
    text "Total Price: 10000", size: 10, style: :bold
  end
end