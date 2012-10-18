# encoding: utf-8
require "prawn/measurement_extensions"
class InvoiceDetailsPdf
  def initialize(invoice_details, view)
    @invoice_details = invoice_details
    @view = view
    initialize_pdf
  end

  def initialize_pdf
    @pdf = Prawn::Document.new page_layout: :portrait, top_margin: 1.5.cm, right_margin: 1.5.cm, bottom_margin: 1.5.cm, left_margin: 1.5.cm, page_size: 'A4'
    @pdf.font_families.update("DejaVuSans" => {:normal => "#{Rails.root}/app/assets/fonts/DejaVuSans.ttf", :bold => "#{Rails.root}/app/assets/fonts/DejaVuSans-Bold.ttf"})
    @pdf.font "DejaVuSans"
  end


  def raw_table_for service
    [["Послуга", "Тариф"]]+
    service.expenses.map { |expense| [expense.name, {content: expense.sum, width: 80}] }
  end

  def draw_pdf
    draw_title
    @invoice_details.services.each do |service|
      draw_service service
    end
  end

  def draw_title
    @pdf.formatted_text [{text: "Деталі нарахувань за #{I18n.t("date.month_names")[@invoice_details.period.begin.month]}", styles: [:bold], size: 10.pt}]
    @pdf.move_down 1.mm
    @pdf.stroke_horizontal_rule
    @pdf.move_down 0.8.cm
  end

  def draw_service service
    draw_service_title service
    @pdf.move_down 0.2.cm
    draw_service_table raw_table_for(service)
    @pdf.move_down 0.5.cm
  end

  def draw_service_title service
    @pdf.formatted_text [{text: service.service_name, styles: [:bold], size: 9.pt}]
  end

  def draw_service_table raw_table
    @pdf.font_size 8.pt
    @pdf.table raw_table, :row_colors => ['EEEEEE', 'FFFFFF'], :width => 18.cm do
      position = :center
      self.cell_style = {:border_width => 0.5, :border_color => "999999"}
      columns(1).align = :center
    end
  end

  def render
    draw_pdf
    @pdf.render
  end

end
