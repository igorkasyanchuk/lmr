# encoding: utf-8
require "prawn/measurement_extensions"
class InvoicePdf < Prawn::Document
  def initialize(invoice, view)
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
    lmr_info
    user_info
    line_items
  end
  
  def lmr_info
    font_size 10
    text "Logo and information about LMR"
    stroke_horizontal_rule
    move_down 1.cm    
  end  

  def user_info
    font_size = 12.pt
    data = [["ПІБ:","Петренко П. П.","Адреса:","Роксоляни 2/5"],
            ["№ особового рахунку:","4070000646163","Кількість мешканців:","3 особи"],
            ["","","Розрахункова площа:","89,1 кв.м."],
            ["","","Опалювальна площа:","89,1 кв.м."]]
    table data do
      self.cell_style = {:borders => [],
        :width => 4.5.cm}
    end
    move_down 2.cm
  end
  
  def line_items
    move_down 20
    font_size 8
    table line_item_rows do
      self.width = 18.cm      
      row(0).font_style = :normal
      row(-1).font_style = :bold
      columns(1..3).align = :center
      position = :center
      self.row_colors = ["DDDDDD", "FFFFFF"]
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