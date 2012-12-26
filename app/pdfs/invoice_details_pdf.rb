# encoding: utf-8
require "prawn/measurement_extensions"
class InvoiceDetailsPdf
  include ApplicationHelper
  
  def initialize(invoice_details, view, user_info)
    @invoice_details = invoice_details
    @view = view
    @user_info = user_info
    initialize_pdf
  end

  def initialize_pdf
    @pdf = Prawn::Document.new page_layout: :portrait, margin: 1.5.cm, page_size: 'A4'
    @pdf.font_families.update("DejaVuSans" => {:normal => "#{Rails.root}/app/assets/fonts/DejaVuSans.ttf", :bold => "#{Rails.root}/app/assets/fonts/DejaVuSans-Bold.ttf"})
    @pdf.font "DejaVuSans"
  end


  def raw_table_for service
    [["Послуга", 'Тариф', "Вартість"]]+
    service.expenses.map { |expense| [expense.name, {content: expense.tariff, width: 80}, {content: expense.sum, width: 80}] }
  end

  def draw_pdf
    draw_title
    user_information
    @invoice_details.services.each do |service|
      draw_service service
    end
  end

  def draw_title
    @pdf.formatted_text [{text: "Деталі нарахувань за #{I18n.t("date.month_names")[@invoice_details.period.begin.month]} #{@invoice_details.period.begin.year} року", styles: [:bold], size: 10.pt}]
    @pdf.move_down 1.mm
    @pdf.stroke_horizontal_rule
    @pdf.move_down 7.mm
  end

  def user_information
    @pdf.font_size = 9.pt
    data = [["ПІБ:", @user_info.pib,"Адреса:", user_address(@user_info)],
            ["№ особового рахунку:", @user_info.consumer_code,"Кількість мешканців:", "#{@user_info.people_count} ос."],
            ["","","Розрахункова площа:", "#{@user_info.calc_area} кв.м."],
            ["","","Опалювальна площа:", "#{@user_info.heat_area} кв.м."]]
    @pdf.table data do
      self.cell_style = {:borders => [],
        :width => 4.5.cm, :height => 0.7.cm}
    end
    @pdf.move_down 1.cm
  end

  def draw_service service
    draw_service_title service
    # @pdf.move_down 0.2.cm
    draw_service_table raw_table_for(service)
    @pdf.move_down 0.5.cm
  end

  def draw_service_title service
    @pdf.formatted_text [{text: service.service_name, styles: [:bold], size: 8.5.pt}]
  end

  def draw_service_table raw_table
    @pdf.font_size 8.pt
    @pdf.table raw_table, :row_colors => ['EEEEEE', 'FFFFFF'], :width => 18.cm do
      position = :center
      self.cell_style = {:border_width => 0.5, :border_color => "999999", :height => 0.6.cm}
      self.header = true
      self.row(0).background_color = '999999'
      columns(1).align = :center
      columns(2).align = :center
    end
  end

  def render
    draw_pdf
    @pdf.number_pages "<page>", 
                      {:start_count_at => 0,
                      :at => [@pdf.bounds.right - 50, 0],
                      :align => :right,
                      :size => 8.pt,
                      :page_filter => :all}
    @pdf.render
  end

end
