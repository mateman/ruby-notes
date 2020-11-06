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
        include RN

        def call(name:, **)
           if Dir.exist?("#{path_rns}folders/#{name}")
               warn "No se puede crear un Book con el nombre #{name} por que ya existe uno con ese nombre"
           else 
               Dir.mkdir("#{path_rns}folders/#{name}")
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
        include RN

        def call(name: nil, **options)
          global = options[:global]
           if Dir.exist?("#{path_rns}folders/#{name}") 
               (Dir.new("#{path_rns}folders/#{name}/")).children().map{|d| File.delete("#{path_rns}folders/#{name}/#{d}")}
               Dir.rmdir("#{path_rns}folders/#{name}")
               puts "Book #{name} eliminado con exito"
           else
               warn "No existe un Book con el nombre #{name}"
           end
#         warn "TODO: Implementar borrado del cuaderno de notas con nombre '#{name}' (global=#{global}).\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end

      class List < Dry::CLI::Command
        desc 'List books'

        example [
          '          # Lists every available book'
        ]
        include RN
     
        def call(*)
          (Dir.new("#{path_rns}folders/")).children().map{|d| puts d}
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
        include RN        

        def call(old_name:, new_name:, **)
          if Dir.exist?("#{path_rns}folders/#{new_name}")
             warn "No se puede renombrar porque existe #{new_name}"
          elsif not Dir.exist?("#{path_rns}folders/#{old_name}")
             warn "No se puede renombrar porque no existe #{old_name}"
          else 
             File.rename("#{path_rns}folders/#{old_name}","#{path_rns}folders/#{new_name}")
             puts "Renombrado #{old_name} por #{new_name}"
          end
#          warn "TODO: Implementar renombrado del cuaderno de notas con nombre '#{old_name}' para que pase a llamarse '#{new_name}'.\nPodés comenzar a hacerlo en #{__FILE__}:#{__LINE__}."
        end
      end
    end
  end
end
