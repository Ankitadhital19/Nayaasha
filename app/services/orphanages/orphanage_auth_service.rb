module Orphanages
  class OrphanageAuthService
    attr_reader :params
    attr_accessor :success, :errors, :token, :orphanage

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute_orphanage_sign_in
      handle_orphanage_sign_in
      self
    end

    def execute_orphanage_sign_out(current_user)
      handle_orphanage_sign_out(current_user)
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private

    def handle_orphanage_sign_in
      begin
        @orphanage = Orphanage.find(params[:orphanage_id])
        user = @orphanage.user

        if user&.valid_password?(params[:password]) && user.email == params[:email]
          @token = user.generate_jwt  # Assuming the user has a method to generate JWT
          @success = true
          @errors = []
        else
          @success = false
          @errors << "Invalid email or password"
        end
      rescue ActiveRecord::RecordNotFound
        @success = false
        @errors << "Orphanage not found"
      rescue StandardError => e
        @success = false
        @errors << e.message
      end
    end

    def handle_orphanage_sign_out(current_user)
      if current_user
        # Invalidate the token or perform any necessary logout logic
        current_user.update(jti: SecureRandom.uuid)  # Assuming jti is used for invalidation
        @success = true
        @errors = []
      else
        @success = false
        @errors << "Failed to logout"
      end
    end
  end
end
