
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

      def execute_delete_orphanage
        handle_orphanage_deletion
        self
      end

      def execute_edit_orphanage
        handle_orphanage_edit
        self
      end

      def excecute_get_orphanage
        handle_get_orphanages
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
        if user.present? && user.superadmin?
          @orphanage = Orphanage.new(orphanage_params.merge(user_id: user.id))
           if @orphanage.save!
            @success = true
            @errors = []
           else
            @success = false
            @errors = @orphanage.errors.full_messages
           end
        else
          @success = false
          @errors << "User must be an admin to create an orphanage."
        end
      rescue ActiveRecord::Rollback, ActiveRecord::RecordInvalid => err
        @success = false
        @errors << err.message
      end

      def handle_orphanage_deletion
        @orphanage = Orphanage.find_by!(id: params[:id])
        if @orphanage && user.present? && user.superadmin?
          if @orphanage.destroy
            @success = false
            @errors = @orphanage.errors.full_messages
          end
        else
          @success = false
          @errors << "You are not authorized to perform this action"
        end
      rescue ActiveRecord::RecordNotDestroyed => err
        @success = false
        @errors << err.message
      end

      def handle_orphanage_edit
        @orphanage = Orphanage.find_by!(id: params[:id])
        if user.present? && user.superadmin?
         if @orphanage.update!(orphanage_params.except(:orphanage_id))
          @success = true
          @errors = []
         else
          @success = false
          @errors = @orphanage.errors.full_messages
         end
        else
          @success = false
          @errors << "You are not authorized to perform this action"
        end
      rescue ActiveRecord::RecordInvalid => err
        @success = false
        @errors << err.message
      end

      def handle_get_orphanages
        begin
          @orphanage = Orphanage.order(created_at: :DESC)
          if @orphanage.present?
            @success = true
            @errors = []
          else
            @success = flase
            @errors = [ "Orphanages not found" ]
          end
        end

      rescue ActiveRecord::ActiveRecordError => err
        @success = false
        @errors = [ err.message ]
      end

      def user
        current_user = params[:current_user]
        @user ||= current_user
      end

      def orphanage_params
        ActionController::Parameters.new(params).permit(:name, :location)
      end
    end
  end
