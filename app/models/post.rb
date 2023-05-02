class Post < ApplicationRecord
  has_many :post_tags
  has_many :tags, through: :post_tags

  validates :slug, uniqueness: true

  before_create do
    status = "active"
  end

  default_scope where(:status => "active")
end
