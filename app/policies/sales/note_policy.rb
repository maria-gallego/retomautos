module Sales
  class NotePolicy

    attr_reader :current_user, :note

    def initialize(current_user, note)
      @current_user = current_user
      @note = note
    end

    def create?
      @current_user.has_role?('sales') && @note.buy_process.user == @current_user
    end

    def destroy?
      @current_user.has_role?('sales') && @note.buy_process.user == @current_user
    end

  end
end
