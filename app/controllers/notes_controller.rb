class NotesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_note, only: [:show, :edit, :update, :destroy, :download]
    
    def index
        @notes = current_user.notes.where("book_id is null").order("created_at DESC")
    end
 
    def new
        @note = current_user.notes.new
    end
    
    def create
        @note = current_user.notes.create note_params
    end
    
    def show
    end
    
    def edit
    end

    def update
        @note.update note_params
    end
    
    def destroy
        @note.book_id.nil? ? p = notes_path : p = notes_of_book_path(@note.book_id)
        @note.destroy
        redirect_to p
    end

    def download
        send_data(@note.markdown, filename:"#{@note.title}.html", type: "html", disposition: "attachment")
    end

    def index_notes_of_book
        if current_user.id == Book.find(params[:book_id]).user_id
          @notes = current_user.notes.where("book_id == #{params[:book_id]}").order("created_at DESC")
        else
           redirect_to "#{root_path}403" 
        end
    end 
 
    def new_note_of_book
        @note = current_user.notes.new
        @note.book_id = params[:book_id]
    end


    private

    def note_params
        params.require(:note).permit(:title, :content, :book_id)
    end

    # uso de callback de before_action
    def set_note
        @note = current_user.notes.find(params[:id])
        if @note.nil?
           redirect_to "#{root_path}403"
        end
    end
end
