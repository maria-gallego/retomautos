module Sales
  class NotesController < ApplicationController

    after_action :verify_authorized

    def create!
      note = Note.new(note_params.merge(user_id: current_user.id))
      authorize note,  policy_class: Sales::NotePolicy
      note.save!
      buy_process = note.buy_process
      redirect_to sales_buy_process_path(buy_process)
    end


    def destroy
      note = Note.find(params[:id])
      authorize note,  policy_class: Sales::NotePolicy
      buy_process = note.buy_process
      note.destroy!
      redirect_to sales_buy_process_path(buy_process)
    end

    private

    def note_params
      params.require(:note).permit(:body, :buy_process_id)
    end
  end
end