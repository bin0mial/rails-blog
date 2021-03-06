class Category < ApplicationRecord

  has_many :posts, :dependent => :destroy

  validates :name, presence: true, uniqueness: {case_sensitive: false}

  before_save :downcase_name

  private

  def downcase_name
    self.name.downcase!
  end
end
