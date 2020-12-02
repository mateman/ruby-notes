module RN
  module Models
    module Note
         
      require 'tty-editor'
  
      def exist_note?(path, title)
         File.exist?("#{path}#{title}.rn")
      end
   
      def create(path, title)
         File.write("#{path}#{title}.rn","")
         TTY::Editor.open("#{path}#{title}.rn")
      end
      
      def delete(path, title)
         File.delete("#{path}#{title}.rn")
      end
      
      def edit(path, title)
         TTY::Editor.open("#{path}#{title}.rn")
      end
      
      def export()
      end
      
      def retitle(path, old_title, new_title)
         File.rename("#{path}#{old_title}.rn","#{path}#{new_title}.rn")      
      end
      
      def list(path)
         Dir.new(path).children().map{|d| d.include?('.rn') ? (puts (d.sub(".rn",""))) : nil}
      end
      
      def show(path, title)
#       (File.open("#{path}#{title}.rn")).each_line {|l| puts l} # mi viejo show hasta que vi la clase 29-10-2020
         puts File.read("#{path}#{title}.rn") 

      end
    
    end
  end
end   
