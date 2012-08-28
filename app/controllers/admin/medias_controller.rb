class Admin::MediasController < Admin::DashboardController

  def index
    @medias = Media.recent.all
  end

  def new
    @media = Media.prepare_new
  end

  def edit
    @media = Media.find(params[:id])
    @media.prepare_media
  end

  def create
    create! do |success, failure|
      success.html { redirect_to [:admin, :medias] }
      failure.html { @media.prepare_media; render :new }
    end
  end

  def update
    update! {[:admin, :medias]}
  end

  def destroy
    destroy! {[:admin, :medias]}
  end

end