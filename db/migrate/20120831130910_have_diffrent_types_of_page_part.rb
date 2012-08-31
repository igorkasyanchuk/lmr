class HaveDiffrentTypesOfPagePart < ActiveRecord::Migration
  def change
    add_column :page_parts, :format, :string, :default => PagePart::FORMATS[0]
    PagePart.update_all(:format => PagePart::FORMATS[0])
  end
end
