# encoding: utf-8
class InvoiceDetailsPdf #< Prawn::Document
  def initialize(invoice_details, view)
    @invoice_details = invoice_details
    @view = view

    initialize_pdf
    
  end

  def initialize_pdf
    @pdf = Prawn::Document.new top_margin: 70
    @pdf.font_families.update("DejaVuSans" => {:normal => "#{Rails.root}/app/assets/fonts/DejaVuSans.ttf", :bold => "#{Rails.root}/app/assets/fonts/DejaVuSans-Bold.ttf"})
    @pdf.font "DejaVuSans"
  end


  def raw_table_for service
    service.expenses.map { |expense| [expense.name, {content: expense.sum, width: 80}] }
  end

  def draw_pdf
    draw_title
    @invoice_details.services.each do |service|
      draw_service service
    end
  end

  def draw_title
    @pdf.formatted_text [{text: "Деталі нарахувань за #{@invoice_details.period.begin.strftime('%m.%Y')}", styles: [:bold], size: 25}]

  end

  def draw_service service
    draw_service_title service
    @pdf.move_down 10
    draw_service_table raw_table_for(service)
    @pdf.move_down 15
  end

  def draw_service_title service
    @pdf.formatted_text [{text: service.service_name, styles: [:bold]}]
  end

  def draw_service_table raw_table
    @pdf.table raw_table, :row_colors => ['DDDDDD', 'FFFFFF'], :width => 540 do
      position = :center
    end
  end

  def render
    draw_pdf
    @pdf.render
  end

end
