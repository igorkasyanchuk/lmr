# encoding: utf-8
class InvoicePdf < Prawn::Document
  def initialize(invoice, view)
    super(top_margin: 70)
    @invoice = invoice
    @view = view
    font_families.update("DejaVuSans" => {:normal => "#{Rails.root}/app/assets/fonts/DejaVuSans.ttf", :bold => "#{Rails.root}/app/assets/fonts/DejaVuSans-Bold.ttf"})
    font "DejaVuSans"
    invoice_number
    line_items
    # total_price
  end
  
  def invoice_number
    text "invoice 4070000646163", size: 20, style: :bold
  end
  
  def line_items
    move_down 20
    font_size 8
    table line_item_rows do      
      # row(0).font_style = :bold
      row(-1).font_style = :bold
      # columns(1..3).align = :right
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