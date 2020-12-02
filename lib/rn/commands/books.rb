module RN
  module Commands
    module Books
      class Create < Dry::CLI::Command
        desc 'Create a book'

        argument :name, required: true, desc: 'Name of the book'

        example [
          '"My book" # Creates a new book named "My book"',
          'Memoires  # Creates a new book named "Memoires"'
        ]
        include RN::Models::Book

        def call(name:, **)
           if exist_book?(name)
               warn "No se puede crear un Book con el nombre #{name} por que ya existe uno con ese nombre"
           else 
               create(name)
               puts "Nuevo Book #{name} creado con exito"
           end
#          warn "TODO: Implementar creación del cuaderno de notas con nombre '#{name}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Delete < Dry::CLI::Command
        desc 'Delete a book'

        argument :name, required: false, desc: 'Name of the book'
        option :global, type: :boolean, default: false, desc: 'Operate on the global book'

        example [
          '--global  # Deletes all notes from the global book',
          '"My book" # Deletes a book named "My book" and all of its notes',
          'Memoires  # Deletes a book named "Memoires" and all of its notes'
        ]
        include RN::Models::Book

        def call(name: nil, **options)
          global = options[:global]
           if exist_book?(name) 
               delete(name)
               puts "Book #{name} eliminado con exito"
           else
               warn "No existe un Book con el nombre #{name}"
           end
#         warn "TODO: Implementar borrado del cuaderno de notas con nombre '#{name}' (global=#{global}).\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Exports < Dry::CLI::Command
        desc 'export all notes in a book'

        argument :name, required: false, desc: 'Name of the book'
        option :global, type: :boolean, default: false, desc: 'Operate on the global book'

        example [
          '--global  # Exports all notes from the global book',
          '"My book" # Exports all notes in a book named "My book"',
          'Memoires  # Exports all notes in a book named "Memoires"'
        ]
        include RN::Models::Book

        def call(name: nil, **options)
          global = options[:global]
           if exist_book?(name) 
               exports(name)               
               puts "Exportado todos las notas de Book #{name} con exito"
           else
               warn "No existe un Book con el nombre #{name}"
           end
        end
      end

      class Exports_all < Dry::CLI::Command
        desc 'Export all notes from all books'

        example [
          '           # Export all notes from all books'
        ]
        
        include RN::Models::Book
        
        def call(*)
           exports_all()
           puts "Exportada todas las notas con exito"
        end

      end

      class List < Dry::CLI::Command
        desc 'List books'

        example [
          '          # Lists every available book'
        ]
        
        include RN::Models::Book
     
        def call(*)
           list()
#          warn "TODO: Implementar listado de los cuadernos de notas.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class Rename < Dry::CLI::Command
        desc 'Rename a book'

        argument :old_name, required: true, desc: 'Current name of the book'
        argument :new_name, required: true, desc: 'New name of the book'

        example [
          '"My book" "Our book"         # Renames the book "My book" to "Our book"',
          'Memoires Memories            # Renames the book "Memoires" to "Memories"',
          '"TODO - Name this book" Wiki # Renames the book "TODO - Name this book" to "Wiki"'
        ]
        
        include RN::Models::Book        

        def call(old_name:, new_name:, **)
          if exist_book?(new_name)
             warn "No se puede renombrar porque existe #{new_name}"
          elsif not exist_book?(old_name)
             warn "No se puede renombrar porque no existe #{old_name}"
          else 
             rename(old_name, new_name)
             puts "Renombrado #{old_name} por #{new_name}"
          end
#          warn "TODO: Implementar renombrado del cuaderno de notas con nombre '#{old_name}' para que pase a llamarse '#{new_name}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end
    end
  end
end
