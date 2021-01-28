class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :delete_all, inverse_of: :user
  has_many :notes, dependent: :delete_all, inverse_of: :user
  
  validates_associated :books
  validates_associated :notes
end
