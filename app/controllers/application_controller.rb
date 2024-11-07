class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern


    set_current_tenant_through_filter
    before_action :handle_current_tenant

    skip_before_action :verify_authenticity_token

    private

    def current_user
      token = request.headers["Authorization"].to_s.split(" ").last
      return nil if token.blank?

      begin
        decoded_token = JWT.decode(token, Rails.application.credentials.development.devise_jwt_secret_key!, true, { algorithm: "HS256" })
        User.find_by(id: decoded_token[0]["id"], jti: decoded_token[0]["jti"])
      rescue JWT::DecodeError, ActiveRecord::RecordNotFound
        nil
      end
    end

    def handle_current_tenant
      return nil unless current_user
      current_organization = current_user.organization
      set_current_tenant(current_organization)
    end
end
