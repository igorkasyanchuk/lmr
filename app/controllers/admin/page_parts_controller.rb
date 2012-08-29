class Admin::PagePartsController < Admin::DashboardController
  defaults :resource_class => PagePart, :collection_name => 'page_parts', :instance_name => 'page_part'
  before_filter :admin_required

  def update
    update! {[:admin, :page_parts]}
  end

end