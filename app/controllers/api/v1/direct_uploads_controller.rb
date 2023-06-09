class Api::V1::DirectUploadsController < ActiveStorage::DirectUploadsController
  include Authorization
  before_action :authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:create]
  
  def create
    key = build_blob_key
    blob = ActiveStorage::Blob.create! **blob_args, key: key

    json_resp = direct_upload_json(blob)

    json_resp[:file_url] = params[:public] == 'true' ?
      File.join(ENV['AWS_CLOUDFRONT_HOST'], key.split('/', 2).first, key.split('/', 2).last.split('/').map{|p| URI.encode_www_form_component(p) }.join('/')) :
      File.join(request.base_url, 'rails/active_storage/blobs', json_resp['signed_id'], URI.encode_www_form_component(json_resp['filename']))

    render json: json_resp
  end

  private

    def build_blob_key
      key = "#{ActiveStorage::Blob.generate_unique_secure_token}"

      if namespace = params[:namespace]
        key = "#{namespace}/#{key}"
      end
      # If file is public then
      #
      # Prepend key with /public-assets
      # Append filename after key
      #
      if params[:public] == 'true'
        key = File.join(ENV['AWS_PUBLIC_ASSETS_FOLDER'], "#{key}_#{blob_args[:filename]}")
      end

      key
    end

    def render_error(message, status = :bad_request)
      Rails.logger.warn { message }
      render json: { errors: [{ detail: message }] }, status: status
    end
end