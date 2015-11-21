class Post < ActiveRecord::Base
  has_many :post_subs, dependent: :destroy

  has_many :subs,
    through: :post_subs,
    source: :sub

  belongs_to :author,
    class_name: "User"

  def is_author?(user)
    self.author == user
  end
end
