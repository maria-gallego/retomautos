module Sales
  class NotePolicy

    attr_reader :current_user, :note

    def initialize(current_user, note)
      @current_user = current_user
      @note = note
    end

    def create?
      buy_process = @note.buy_process
      @current_user.has_role?('sales') && buy_process.user == @current_user && buy_process.active?
    end

    def destroy?
      buy_process = @note.buy_process
      @current_user.has_role?('sales') && buy_process.user == @current_user && buy_process.active?
    end

  end
end
