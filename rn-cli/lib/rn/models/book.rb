module RN
  module Models
    module Book

       include RN
       include RN::Models::Note

       def path_book(book)
          "#{path_rns}folders/#{book}/"
       end   
          
       def exist_book?(name)
          Dir.exist?("#{path_rns}folders/#{name}")
       end
       
       def create(name)
          Dir.mkdir("#{path_rns}folders/#{name}")
       end
       
       def delete(name)
          (Dir.new("#{path_rns}folders/#{name}/")).children().map{|d| File.delete("#{path_rns}folders/#{name}/#{d}")}
          Dir.rmdir("#{path_rns}folders/#{name}")
       end
       
       def rename(old_name, new_name)
          File.rename("#{path_rns}folders/#{old_name}","#{path_rns}folders/#{new_name}")
       end
       
       def list()
          (Dir.new("#{path_rns}folders/")).children().map{|d| puts d}
       end
       
       def exports(name)
          renderer = Redcarpet::Render::HTML.new(prettify: true)
          markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
          (Dir.new("#{path_rns}folders/#{name}/")).children().map{|d| File.extname(d)==(".rn") ? export("#{path_rns}folders/#{name}/",d.gsub(/.rn$/,'')) : nil } 
       end
       
       def exports_all()
          renderer = Redcarpet::Render::HTML.new(prettify: true)
          markdown = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)
          (Dir.new("#{path_rns}folders/")).children().map{|d| (Dir.new("#{path_rns}folders/#{d}/")).children().map{|e| File.extname(e)==(".rn") ? export("#{path_rns}folders/#{d}/",e.gsub(/.rn$/,'')) : nil }}  
          (Dir.new("#{path_rns}global/")).children().map{|d| File.extname(d)==(".rn") ? export("#{path_rns}global/",d.gsub(/.rn$/,'')) : nil }
       end
       
    end
  end
end 
