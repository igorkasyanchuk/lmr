#encoding: utf-8
class AddUkranianTitlesToPermanentStaticPages < ActiveRecord::Migration
  def up
    {
      'payments' => 'Оплати',
      'about' => 'Про нас',
      'help' => 'Допомога',
      'contacts' => "Зв'язок з нами"
    }.each_pair do |identifier, title|
      Page.find_or_create_by_identifier(identifier).update_attribute(:title, title)
    end
  end

  def down
    Page.where(:identifier => %w{payments about help contacts}).update_all(:title => nil)
  end
end
