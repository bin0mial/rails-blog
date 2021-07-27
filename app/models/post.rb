class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: "User"
  has_many_attached :attachments, :dependent => :destroy

  validates :creator, presence: true
  validates :category, presence: true
  validates :title, presence: true, length: { in: 6..50 }
  validates :body, presence: true, length: { in: 10..500 }

end
