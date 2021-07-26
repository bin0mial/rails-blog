class Post < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name:  "User"
  has_many_attached :attachments, :dependent => :destroy
end
