class BooksController < ApplicationController
    require 'rubygems'
    require 'zip'
    before_action :authenticate_user!
    before_action :set_book, only: [:show, :edit, :update, :destroy, :download ]
  
    def index
        @books = current_user.books.order('LOWER(title)')
#        @books = @books.sort_by {|book| book.title} # Ruby Sorting
    end 
       
    def new
        @book = current_user.books.new
    end
    
    def create
        @book = current_user.books.new book_params
        @book.user_id = current_user.id
        @book.save
    end

    def show
        redirect_to notes_of_book_path(@book.id)
    end
    
    def edit
    end
    
    def update
        @book.update book_params
    end
    
    def destroy
        @book.destroy
    end

    def download
        notes = currten_user.notes.where("book_id == #{params[:id]}")
        Dir.mkdir("tmp/#{current_user.id}")
        Dir.mkdir("tmp/#{current_user.id}/#{@book.title}")
        zipfile = Zip::File.open("tmp/#{current_user.id}.zip", Zip::File::CREATE)
        zipfile.mkdir("#{@book.title}")
        notes.each do |n|
            File.write("tmp/#{current_user.id}/#{@book.title}/#{n.title}.html",n.markdown)
            zipfile.add("#{@book.title}/#{n.title}.html", "tmp/#{current_user.id}/#{@book.title}/#{n.title}.html" )
        end
        zipfile.close
        (Dir.new("tmp/#{current_user.id}/#{@book.title}")).children().map{|d| File.delete("tmp/#{current_user.id}/#{@book.title}/#{d}")}
        Dir.rmdir("tmp/#{current_user.id}/#{@book.title}")
        Dir.rmdir("tmp/#{current_user.id}/")
        send_data(File.read("tmp/#{current_user.id}.zip"), filename: "#{@book.title}.zip", type: 'application/zip' )
        File.delete("tmp/#{current_user.id}.zip")
    end


    def download_all
        books = current_user.books
        Dir.mkdir("tmp/#{current_user.id}")
        zipfile = Zip::File.open("tmp/#{current_user.id}.zip", Zip::File::CREATE)
        books.each do |b|
              Dir.mkdir("tmp/#{current_user.id}/#{b.title}")
              zipfile.mkdir("#{b.title}")
              notes = current_user.notes.where("book_id == #{b.id}")
              notes.each do |n|
                 File.write("tmp/#{current_user.id}/#{b.title}/#{n.title}.html",n.markdown)
                 zipfile.add("#{b.title}/#{n.title}.html", "tmp/#{current_user.id}/#{b.title}/#{n.title}.html" )
              end
        end
        Dir.mkdir("tmp/#{current_user.id}global")
        notes = current_user.notes.where("book_id is null")
        notes.each do |n|
             File.write("tmp/#{current_user.id}global/#{n.title}.html",n.markdown)
             zipfile.add("#{n.title}.html", "tmp/#{current_user.id}global/#{n.title}.html" )
        end
        zipfile.close
        (Dir.new("tmp/#{current_user.id}")).children().map{|d| (Dir.new("tmp/#{current_user.id}/#{d}")).children.map{|f| File.delete("tmp/#{current_user.id}/#{d}/#{f}")}}
        (Dir.new("tmp/#{current_user.id}")).children().map{|d| Dir.rmdir("tmp/#{current_user.id}/#{d}")}
        (Dir.new("tmp/#{current_user.id}global")).children().map{|f| File.delete("tmp/#{current_user.id}global/#{f}")}        
        Dir.rmdir("tmp/#{current_user.id}global")
        Dir.rmdir("tmp/#{current_user.id}")
        send_data(File.read("tmp/#{current_user.id}.zip"), filename: "#{current_user.name}.zip", type: 'application/zip' )
        File.delete("tmp/#{current_user.id}.zip")
    end

    private

    def book_params
        params.require(:book).permit(:title)
    end

    def set_book
        @book = current_user.books.find(params[:id])
        if @book.nil?
             render :'errors/403', status: :forbidden, :layout => false 
        end
    end
end
