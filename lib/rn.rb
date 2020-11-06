module RN
  autoload :VERSION, 'rn/version'
  autoload :Commands, 'rn/commands'
  
  # Agregar aquí cualquier autoload que sea necesario para que se cargue las clases y
  # módulos del modelo de datos.
  # Por ejemplo:
  # autoload :Note, 'rn/note'


 def path_rns
   return "#{Dir.home}/.my_rns/"
 end

 def initialize
  if not(Dir.exist?("#{Dir.home}/.my_rns"))
     Dir.mkdir("#{Dir.home}/.my_rns")
  end
  if not(Dir.exist?("#{Dir.home}/.my_rns/global"))
     Dir.mkdir("#{Dir.home}/.my_rns/global")
  end
  if not(Dir.exist?("#{Dir.home}/.my_rns/folders"))
     Dir.mkdir("#{Dir.home}/.my_rns/folders")    
  end 
 end

end
