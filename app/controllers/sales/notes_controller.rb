module Sales
  class NotesController < ApplicationController

    def create
      # TODO: authorization
      note = Note.create!(note_params.merge(user_id: current_user.id))
      buy_process = note.buy_process
      redirect_to sales_buy_process_path(buy_process)
    end

    def update
    end

    def destroy
      note = Note.find(params[:id])
      buy_process = note.buy_process
      note.destroy
      redirect_to sales_buy_process_path(buy_process)
    end

    private

    def note_params
      params.require(:note).permit(:body, :buy_process_id)
    end
  end
end