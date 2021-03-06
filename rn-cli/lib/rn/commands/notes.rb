module RN
  module Commands
    module Notes
      class Create < Dry::CLI::Command
        desc 'Create a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Creates a note titled "todo" in the global book',
          '"New note" --book "My book" # Creates a note titled "New note" in the book "My book"',
          'thoughts --book Memoires    # Creates a note titled "thoughts" in the book "Memoires"'
        ]
        
        include RN
        include RN::Models::Note

        def call(title:, **options)
          book = options[:book]
          if book.nil?
             path = path_global()
          elsif exist_book?(book)
             path = path_book(book)
          else
             path = nil 
          end
          if path.nil?
            warn "No existe libro llamado '#{book}'\n"
          elsif exist_note?(path, title) 
            warn "Existe una Note llamada '#{title}'\n"
          else
            create(path, title)
            puts "Creada la Note #{title}"
          end
#          warn "TODO: Implementar creación de la nota con título '#{title}' (en el libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Deletes a note titled "todo" from the global book',
          '"New note" --book "My book" # Deletes a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Deletes a note titled "thoughts" from the book "Memoires"'
        ]

        include RN
        include RN::Models::Note


        def call(title:, **options)
          book = options[:book]
          if book.nil?
             path = path_global()
          elsif exist_book?(book)
             path = path_book(book)
          else
             path = nil 
          end
          if path.nil?
             warn "No existe el Book #{book}"
          elsif exist_note?(path,title)
             delete(path,title)
             puts "Borrada la Note #{title}"
          else 
             warn "No existe una Note llamada #{title}\n"
          end
#         warn "TODO: Implementar borrado de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Edit < Dry::CLI::Command
        desc 'Edit the content a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Edits a note titled "todo" from the global book',
          '"New note" --book "My book" # Edits a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Edits a note titled "thoughts" from the book "Memoires"'
        ]
        include RN
        include RN::Models::Note

        def call(title:, **options)
          book = options[:book]
          if book.nil?
             path = path_global()
          elsif exist_book?(book)
             path = path_book(book)
          else
             path = nil 
          end
          if path.nil?
             warn "No existe el Book #{book}"
          elsif exist_note?(path,title)
             edit(path,title)
             puts "Editada la Note #{title}"
          else 
             warn "No existe una Note llamada #{title}\n"
          end
#          warn "TODO: Implementar modificación de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Export < Dry::CLI::Command
        desc 'Export the content a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Export a note titled "todo" from the global book',
          '"New note" --book "My book" # Export a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Export a note titled "thoughts" from the book "Memoires"'
        ]
        include RN
        include RN::Models::Note

        def call(title:, **options)
          book = options[:book]
          if book.nil?
             path = path_global()
          elsif exist_book?(book)
             path = path_book(book)
          else
             path = nil 
          end
          if path.nil?
             warn "No existe el Book #{book}"
          elsif exist_note?(path, title)
             export(path, title)
             puts "Exportada la Note #{title} como #{title}.html"
          else 
             warn "No existe una Note llamada #{title}\n"
          end
#          warn "TODO: Implementar modificación de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Retitle < Dry::CLI::Command
        desc 'Retitle a note'

        argument :old_title, required: true, desc: 'Current title of the note'
        argument :new_title, required: true, desc: 'New title for the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo TODO                                 # Changes the title of the note titled "todo" from the global book to "TODO"',
          '"New note" "Just a note" --book "My book" # Changes the title of the note titled "New note" from the book "My book" to "Just a note"',
          'thoughts thinking --book Memoires         # Changes the title of the note titled "thoughts" from the book "Memoires" to "thinking"'
        ]
        include RN
        include RN::Models::Note

        def call(old_title:, new_title:, **options)
          book = options[:book]
          if book.nil?
             path = path_global()
          elsif exist_book?(book)
             path = path_book(book)
          else
             path = nil 
          end
          if path.nil?
             warn "No existe el Book #{book}"
          elsif exist_note?(path, title) && not(exist_note?(path, new_title))
             retitle(path, old_title, new_title)
             puts "Renombrado #{old_title} por #{new_title}"
          elsif exist_note?(path, new_title)
             warn "Existe una Note llamada #{new_title}\n"
          else
             warn "No existe una Note llamada #{old_title}\n"
          end
          
#          warn "TODO: Implementar cambio del título de la nota con título '#{old_title}' hacia '#{new_title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class List < Dry::CLI::Command
        desc 'List notes'

        option :book, type: :string, desc: 'Book'
        option :global, type: :boolean, default: false, desc: 'List only notes from the global book'

        example [
          '                 # Lists notes from all books (including the global book)',
          '--global         # Lists notes from the global book',
          '--book "My book" # Lists notes from the book named "My book"',
          '--book Memoires  # Lists notes from the book named "Memoires"'
        ]
        include RN
        include RN::Models::Note

        def call(**options)
          book = options[:book]
          global = options[:global]
          if book.nil?
              path = path_global()
          elsif not(book.nil?) && exist_book?(book)
             path = path_book(book)
          else
             warn "No existe el Book " 
          end
           list(path)
#          warn "TODO: Implementar listado de las notas del libro '#{book}' (global=#{global}).\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Show < Dry::CLI::Command
        desc 'Show a note'

        argument :title, required: true, desc: 'Title of the note'
        option :book, type: :string, desc: 'Book'

        example [
          'todo                        # Shows a note titled "todo" from the global book',
          '"New note" --book "My book" # Shows a note titled "New note" from the book "My book"',
          'thoughts --book Memoires    # Shows a note titled "thoughts" from the book "Memoires"'
        ]
        include RN
        include RN::Models::Note

        def call(title:, **options)
          book = options[:book]
          if book.nil?
             path = path_global()
          elsif exist_book?(book)
             path = path_book(book)
          else
             path = nil 
          end
          if path.nil?
             warn "No existe el Book #{book}"
          elsif exist_note?(path, title)
             show(path, title)
          else 
             warn "No existe una Note llamada #{title}\n"
          end
#          warn "TODO: Implementar vista de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end
    end
  end
end
