class Book < ApplicationRecord
    belongs_to :user, inverse_of: :books
    has_many :notes, dependent: :delete_all, inverse_of: :book

    validates :title, presence:true, length: { maximum: 255 }
    validates :user_id, presence: true
    validates_uniqueness_of :title, scope: :user_id

##    No lo necesito mas, ya que ahora le pido los books al current_user
#    scope :books_for_user, -> (user_id){ where("user_id == ?", user_id)} 

    
    def to_s
        title
    end
    
end
