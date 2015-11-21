class Sub < ActiveRecord::Base
  has_many :post_subs, dependent: :destroy

  belongs_to :moderator,
    class_name: "User"

  has_many :posts,
    through: :post_subs,
    source: :post

  def is_moderator?(user)
    self.moderator == user
  end
end
