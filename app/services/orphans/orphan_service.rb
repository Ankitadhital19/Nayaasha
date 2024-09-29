module Orphans
  class OrphanService
    attr_reader :params
    attr_accessor :success, :errors, :orphan

    def initialize(params = {})
      # @user = user
      @params = params
      @success = false
      @errors = []
    end

    def execute_create_orphan
      handle_orphan_creation
      self
    end

    # def execute_delete_orphan
    #   handle_orphan_deletion
    #   self
    # end

    # def execute_edit_orphan
    #   handle_orphan_edit
    #   self
    # end

    # def excecute_get_orphan
    #   handle_get_orphans
    #   self
    # end

    def success?
      @success || @errors.empty?
    end

    def errors
      @errors.join(",")
    end

    private

    def handle_orphan_creation
      # Find the orphanage by ID
      orphanage = Orphanage.find_by(id: params[:orphanage_id])

      # Check if the orphanage was found
      if orphanage.nil?
        @errors << "Orphanage not found."
        return
      end

      # Check if the orphanage is an admin
      if orphanage.admin?
        # Create a new orphan with the provided parameters and link to the orphanage
        @orphan = Orphan.new(orphan_params.merge(orphanage_id: orphanage.id))

        # Attempt to save the orphan
        if @orphan.save
          @success = true
          @errors = []  # Reset errors on success
        else
          @success = false
          @errors = @orphan.errors.full_messages  # Capture validation errors
        end
      else
        @success = false
        @errors << "The orphanage must be an admin to create an orphan."
      end
    rescue ActiveRecord::Rollback, ActiveRecord::RecordInvalid => err
      @success = false
      @errors << err.message  # Capture any exceptions during save
    end


    # def handle_orphanage_deletion
    #   @orphanage = Orphanage.find_by!(id: params[:id])
    #   if @orphanage && user.present? && user.superadmin?
    #     if @orphanage.destroy
    #       @success = false
    #       @errors = @orphanage.errors.full_messages
    #     end
    #   else
    #     @success = false
    #     @errors << "You are not authorized to perform this action"
    #   end
    # rescue ActiveRecord::RecordNotDestroyed => err
    #   @success = false
    #   @errors << err.message
    # end

    # def handle_orphanage_edit
    #   @orphanage = Orphanage.find_by!(id: params[:id])
    #   if user.present? && user.superadmin?
    #    if @orphanage.update!(orphanage_params.except(:orphanage_id))
    #     @success = true
    #     @errors = []
    #    else
    #     @success = false
    #     @errors = @orphanage.errors.full_messages
    #    end
    #   else
    #     @success = false
    #     @errors << "You are not authorized to perform this action"
    #   end
    # rescue ActiveRecord::RecordInvalid => err
    #   @success = false
    #   @errors << err.message
    # end

    # def handle_get_orphanages
    #   begin
    #     @orphanage = Orphanage.order(created_at: :DESC)
    #     if @orphanage.present?
    #       @success = true
    #       @errors = []
    #     else
    #       @success = flase
    #       @errors = [ "Orphanages not found" ]
    #     end
    #   end

    # rescue ActiveRecord::ActiveRecordError => err
    #   @success = false
    #   @errors = [ err.message ]
    # end

    def user
      @user ||=  params[:current_user]
    end

    def orphanage_params
      ActionController::Parameters.new(params).permit(:name, :age, :gender)
    end
  end
end
