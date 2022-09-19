class RedactorRails::DocumentsController < ApplicationController
  before_filter :redactor_authenticate_user!

  def index
    @documents = RedactorRails.document_model.where(
        RedactorRails.document_model.new.respond_to?(RedactorRails.devise_user) ? { RedactorRails.devise_user_key => redactor_current_user.id } : { })
    render :json => @documents.to_json
  end

  def create
    processed_files = RedactorRails::Backend::ProcessFiles.new(
      files: params[:file],
      user: redactor_current_user,
      type: RedactorRails::Document
    ).call

    return render json: processed_files unless processed_files.key?('error')
    render json: processed_files[:error]
  end

  private

  def redactor_authenticate_user!
    if RedactorRails.document_model.new.has_attribute?(RedactorRails.devise_user)
      super
    end
  end
end
