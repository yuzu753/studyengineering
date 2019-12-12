class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookshelves, dependent: :destroy
  has_many :books,  { through: :bookshelves }
  has_many :records, dependent: :destroy
  has_many :recommendeds, dependent: :destroy
  has_many :todolists, dependent: :destroy

  validates :name, :email, presence: true

  def havebook(book)
    self.books.find_by(book_code: book.book_code)
  end

  def already_recommended?(book)
    self.recommendeds.exists?(book_id: book.id)
  end

  def ckeck_date(todolist)
    limit_time = self.todolists.find_by(id: todolist.id)
    (limit_time.deadline - Date.today).to_i
  end

end
