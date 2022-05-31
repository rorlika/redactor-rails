class RedactorRails::PicturesController < ApplicationController
  before_filter :redactor_authenticate_user!

  def index
    @pictures = RedactorRails.picture_model.where(
        RedactorRails.picture_model.new.respond_to?(RedactorRails.devise_user) ? { RedactorRails.devise_user_key => redactor_current_user.id } : { })
    render :json => @pictures.to_json
  end

  def create
    processed_files = RedactorRails::Backend::ProcessFiles.new(
      files: params[:file],
      user: redactor_current_user
    ).call

    return render json: processed_files unless processed_files.key?('error')
    render json: processed_files[:error]
  end

  private

  def redactor_authenticate_user!
    if RedactorRails.picture_model.new.has_attribute?(RedactorRails.devise_user)
      super
    end
  end
end
