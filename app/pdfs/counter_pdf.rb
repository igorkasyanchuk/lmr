# encoding: utf-8
require "prawn/measurement_extensions"
class CounterPdf
  include ApplicationHelper

  def initialize(counter, year)
    @counter = counter
    @year = year
    initialize_pdf
  end

  def initialize_pdf
    @pdf = Prawn::Document.new page_layout: :portrait, margin: 1.5.cm, page_size: 'A4'
    @pdf.font_families.update("DejaVuSans" => {:normal => "#{Rails.root}/app/assets/fonts/DejaVuSans.ttf", :bold => "#{Rails.root}/app/assets/fonts/DejaVuSans-Bold.ttf"})
    @pdf.font "DejaVuSans"
  end

  def draw_pdf
    draw_title
    if @counter && @counter.has_history?(@year)
      line_items
    else
      @pdf.formatted_text [{text: 'Немає даних', size: 10.pt}]
    end
  end

  def draw_title
    @pdf.formatted_text [{text: "Історія по лічильнику #{@counter.type_name} (Держ.номер: #{@counter.state_number}) за #{@year} рік", styles: [:bold], size: 10.pt}]
    @pdf.move_down 1.mm
    @pdf.stroke_horizontal_rule
    @pdf.move_down 7.mm
  end

  def line_items
    @pdf.move_down 20
    @pdf.font_size 7.5
    @pdf.table line_item_rows do
      self.cell_style = {:border_width => 0.5, :border_color => "999999"}
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
    [["Період", "Дата", "Початкові\nпокази", "Кінцеві\nпокази", "Кількість", "Вид\nоперації", "Скореговано", "Корегування\nкін. показу"]] +
    @counter.history(@year).map do |counter|
      [counter_month(counter.month), '', counter.begin_state, counter.end_state, '', '', '', '']
    end
  end

  def render
    draw_pdf
    @pdf.render
  end

end
