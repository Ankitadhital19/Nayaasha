module Orphans
  class OrphanService
    attr_reader :params
    attr_accessor :success, :errors, :orphan, :orphans

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

    def execute_delete_orphan
      handle_orphan_deletion
      self
    end

    def execute_edit_orphan
      handle_orphan_edit
      self
    end

    def excecute_get_orphans
      handle_get_orphans
      self
    end

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
      if user.present? && orphanage.admin?
        @orphan = orphanage.orphans.build(orphan_params)

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
      @errors << err.message
    end


    def handle_orphan_deletion
      @orphan = Orphan.find_by!(id: params[:id])

      orphanage = Orphanage.find_by(id: @orphan.orphanage_id)

      if @orphan && orphanage.present? && orphanage.admin?
        if @orphan.destroy
          @success = true
          @errors = []
        else
          @success = false
          @errors = @orphan.errors.full_messages
        end
      else
        @success = false
        @errors << "You are not authorized to perform this action."
      end
    rescue ActiveRecord::RecordNotDestroyed => err
      @success = false
      @errors << err.message
    end


    def handle_orphan_edit
      @orphan = Orphan.find_by!(id: params[:id])
      orphanage = Orphanage.find_by(id: @orphan.orphanage_id)  # Retrieve orphanage

      if orphanage.present? && orphanage.admin?  # Check if the orphanage exists and is admin
        if @orphan.update(orphan_params.except(:orphan_id))
          @success = true
          @errors = []
        else
          @errors = @orphan.errors.full_messages
        end
      else
        @errors << "You are not authorized to perform this action."
      end
    rescue ActiveRecord::RecordInvalid => err
      @errors << err.message
    end

    def handle_get_orphans
      @orphans = Orphan.order(created_at: :desc)
      if @orphans.present?
        @success = true
        @errors = []
      else
        @success = false
        @errors << "No orphans found."
      end
    rescue ActiveRecord::ActiveRecordError => err
      @success = false
      @errors << err.message
      nil
    end

    def user
      @user ||=  params[:current_user]
    end

    def orphan_params
      ActionController::Parameters.new(params).permit(:name, :age, :gender)
    end
  end
end
