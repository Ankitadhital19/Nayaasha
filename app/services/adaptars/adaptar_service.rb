module Adaptars
  class AdaptarService
    attr_reader :params
    attr_accessor :success, :errors, :adaptar

    def initialize(params = {})
      @params = params
      @success = false
      @errors = []
    end

    def execute_adapatar_reg
      handle_adaptar_registration
      self
    end

    def execute_adaptar_sign_in
      handle_adaptar_sign_in
      self
    end

    def execute_Adaptar_sign_out(current_user)
      handle_adaptar_sign_out(current_user)
      self
    end

    def excecute_get_adaptars
      handle_fetch_adaptars
      self
    end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(", ")
    end

    private

    def handle_adaptar_registration
      @adaptar = ::Adaptar.new(sign_up_params)

      if @adaptar.save
        @success = true
      else
        @success = false
        @errors = @adaptar.errors.full_messages
      end
    end

    def handle_adaptar_sign_in
        @adaptar = Adaptar.find_for_authentication(email: params[:email])
        if @adaptar&.valid_password?(params[:password])
          @success = true
          @errors = []
        else
          @success = false
          @errors << "Invalid email or password"
        end
    rescue ActiveRecord::Rollback => err
      @success = false
      @errors << err.message
    end

    def handle_adaptar_sign_out(current_user)
      if current_user.present?
        sign_out(current_user)
        @success = true
        @errors = []
      else
        @success = false
        @errors << "No user signed in"
      end
    rescue StandardError => err
      @success = false
      @errors << err.message
    end

    def handle_fetch_adaptars
      @adaptar = Adaptar.order(created_at: :desc)
      if @adaptar.present?
        @success = true
        @errors = []
      else
        @success = false
        @errors << "No orphans found."
      end
    rescue ActiveRecord::ActiveRecordError => err
      @success = false
      @errors << err.message
    end

    def sign_up_params
      ActionController::Parameters.new(params).permit(:email, :password, :password_confirmation)
    end
  end
end
