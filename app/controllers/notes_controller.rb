class NotesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_note, only: [:show, :edit, :update, :destroy, :download]
    
    def index
        @notes = current_user.notes.search(current_user.id, params[:search]).paginate(page: params[:page], per_page: 5).order("created_at DESC")
    end
 
    def new
        @note = current_user.notes.new
    end
    
    def create
        @note = current_user.notes.create note_params
        if @note.errors.empty?
           redirect_to note_path?(@note), notice: "Se creo la nota '#{@note.title}'"
        end
    end
    
    def show
       @title = @note.title
       @content = @note.show_content
    end
    
    def edit
    end

    def update
        @note.update note_params
        if @note.errors.empty?
           redirect_to note_path?(@note), notice: "Se actualizo la nota '#{@note.title}'"
        end
    end
    
    def destroy
        @note.book_id.nil? ? p = notes_path : p = notes_of_book_path(@note.book_id)
        title = @note.title
        @note.destroy
        redirect_to p, notice: "La nota '#{ title }' se elimino exitosamente"
    end

    def download
        send_data(@note.markdown, filename:"#{@note.title}.html", type: "html", disposition: "attachment")
    end

    def index_notes_of_book
        if current_user.id == Book.find(params[:book_id]).user_id
          @notes = current_user.notes.search(current_user.id, params[:search], params[:book_id] ).paginate(page: params[:page], per_page: 5).order("created_at DESC")
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

    def note_path?(nota)
        nota.book_id.nil? ? p = notes_path : p = notes_of_book_path(nota.book_id)
    end

end
