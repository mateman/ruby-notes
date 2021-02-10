class Note < ApplicationRecord
  belongs_to :user, inverse_of: :notes
  belongs_to :book, optional: true, inverse_of: :notes

  validates :title, presence: true, length: { maximum: 255 }, format: { with: /\A(\w|(\S[\w\s]*\S))\z/, message: "no debe comenzar ni terminar con espacios en blanco"}
  validates :content, presence: true
  validates_uniqueness_of :title, scope: [:book_id,:user_id]
  
  def to_s
    title
  end

  def self.search(user, search, book=nil)
     if book== nil
       notes =  where("user_id == #{user} AND book_id is null")
     else
       notes =  where("user_id == #{user} AND book_id == #{book}")
     end
     notes =  notes.where("title like ? OR content like ?", "%#{search}%", "%#{search}%") if search
     notes
  end


  def show_content
      renderer = Redcarpet::Render::HTML.new(prettify: true)
      (Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)).render("#{content}")
  end

  def markdown
      renderer = Redcarpet::Render::HTML.new(prettify: true)
      (Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)).render("###### #{created_at}<br>\n**#{title}**<br>\n #{content}")
  end
end
