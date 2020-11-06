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
        require 'tty-editor'

        def call(title:, **options)
          book = options[:book]
          if book.nil?
             path = "#{path_rns}global/"
          elsif Dir.exist?("#{path_rns}/folders/#{book}")
             path = "#{path_rns}/folders/#{book}/"
          else
             path = nil 
          end
          if path.nil?
            warn "No existe libro llamado '#{book}'\n"
          elsif File.exist?("#{path}#{title}.rn")
            warn "Existe una Note llamada '#{title}'\n"
          else
            File.write("#{path}#{title}.rn","")
            TTY::Editor.open("#{path}#{title}.rn")
            puts "Creada la Note #{title}"
          end
          #warn "TODO: Implementar creación de la nota con título '#{title}' (en el libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
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

        def call(title:, **options)
          book = options[:book]
          if book.nil?
             path = "#{path_rns}global/"
          elsif Dir.exist?("#{path_rns}/folders/#{book}")
             path = "#{path_rns}/folders/#{book}/"
          else
             path = nil 
          end
          if path.nil?
             warn "No existe el Book #{book}"
          elsif File.exist?("#{path}#{title}.rn")
             File.delete("#{path}#{title}.rn")
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
        require 'tty-editor'

        def call(title:, **options)
          book = options[:book]
          if book.nil?
             path = "#{path_rns}global/"
          elsif Dir.exist?("#{path_rns}/folders/#{book}")
             path = "#{path_rns}/folders/#{book}/"
          else
             path = nil 
          end
          if path.nil?
             warn "No existe el Book #{book}"
          elsif File.exist?("#{path}#{title}.rn")
             TTY::Editor.open("#{path}#{title}.rn")
             puts "Editada la Note #{title}"
          else 
             warn "No existe una Note llamada #{title}\n"
          end
#
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

        def call(old_title:, new_title:, **options)
          book = options[:book]
          if book.nil?
             path = "#{path_rns}global/"
          elsif Dir.exist?("#{path_rns}/folders/#{book}")
             path = "#{path_rns}/folders/#{book}/"
          else
             path = nil 
          end
          if path.nil?
             warn "No existe el Book #{book}"
          elsif File.exist?("#{path}#{old_title}.rn") && not(File.exist?("#{path}#{new_title}.rn"))
             File.rename("#{path}#{old_title}.rn","#{path}#{new_title}.rn")
             puts "Renombrado #{old_title} por #{new_title}"
          elsif File.exist?("#{path}#{new_title}.rn")
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

        def call(**options)
          book = options[:book]
          global = options[:global]
          if book.nil?
             (Dir.new("#{path_rns}global/")).children().map{|d| puts (d.sub(".rn",""))}
          elsif not(book.nil?) && Dir.exist?("#{path_rns}/folders/#{book}")
             (Dir.new("#{path_rns}folders/#{book}/")).children().map{|d| puts (d.sub(".rn",""))}
          else
             warn "No existe el Book " 
          end
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

        def call(title:, **options)
          book = options[:book]
          if book.nil?
             path = "#{path_rns}global/"
          elsif Dir.exist?("#{path_rns}/folders/#{book}")
             path = "#{path_rns}/folders/#{book}/"
          else
             path = nil 
          end
          if path.nil?
             warn "No existe el Book #{book}"
          elsif File.exist?("#{path}#{title}.rn")
#             (File.open("#{path}#{title}.rn")).each_line {|l| puts l} # mi viejo show hasta que vi la clase 29-10-2020
             puts File.read("#{path}#{title}.rn") 
          else 
             warn "No existe una Note llamada #{title}\n"
          end
#          warn "TODO: Implementar vista de la nota con título '#{title}' (del libro '#{book}').\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end
    end
  end
end
