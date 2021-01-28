class Note < ApplicationRecord
  belongs_to :user, inverse_of: :notes
  belongs_to :book, optional: true, inverse_of: :notes

  validates :title, presence: true, length: { maximum: 255 }
  validates :content, presence: true
  validates_uniqueness_of :title, scope: [:book_id,:user_id]
  
  def to_s
    title
  end

  def markdown
      renderer = Redcarpet::Render::HTML.new(prettify: true)
      (Redcarpet::Markdown.new(renderer, fenced_code_blocks: true)).render("###### #{created_at}<br>\n**#{title}**<br>\n #{content}")
  end
end
