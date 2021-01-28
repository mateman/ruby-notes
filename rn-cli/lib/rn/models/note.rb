module RN
  module Models
    module Note
      
      require 'tty-editor'
      require 'redcarpet'
  
      def path_global()
         "#{path_rns}global/"
      end
       
      def path_book(book)
         "#{path_rns}folders/#{book}/"
      end   
          
      def exist_book?(name)
         Dir.exist?("#{path_rns}folders/#{name}")
      end
      
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
      
      def export(path, title)
         renderer = Redcarpet::Render::HTML.new(prettify: true)
         markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
         File.write("#{path}#{title}.html",(markdown.render(File.read("#{path}#{title}.rn"))))   
      end
      
      def retitle(path, old_title, new_title)
         File.rename("#{path}#{old_title}.rn","#{path}#{new_title}.rn")      
      end
      
      def list(path)
         Dir.new(path).children().map{|d| File.extname(d)==(".rn") ? (puts (d.sub(/.rn$/,""))) : nil}
      end
      
      def show(path, title)
#       (File.open("#{path}#{title}.rn")).each_line {|l| puts l} # mi viejo show hasta que vi la clase 29-10-2020
         puts File.read("#{path}#{title}.rn") 

      end
    
    end
  end
end   
