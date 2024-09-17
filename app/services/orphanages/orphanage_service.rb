
  module Orphanages
    class OrphanageService
      attr_reader :params
      attr_accessor :success, :errors, :orphanage

      def initialize(params = {})
        # @user = user
        @params = params
        @success = false
        @errors = []
      end

      def execute_create_orphanage
        handle_orphanage_creation
        self
      end

      def success?
        @success || @errors.empty?
      end

      def errors
        @errors.join(",")
      end

      private

      def handle_orphanage_creation
        if user.present? && user.admin?
          @orphanage = ::Orphanage.new(orphange_params)
           if @orphanage.save
            @success = true
           else
            @errors = @orphanage.errors.full_messages
           end
        else
          @errors << "User must be an admin to create an orphanage."
        end
      end

      def orphanage_params
        ActionController::Parameters.new(params).permit(:name, :location)
      end
    end
  end
