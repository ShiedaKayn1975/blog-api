class Api::V1::Public::TagResource < JSONAPI::Resource
  attributes :id, :name, :code, :active, :created_at, :updated_at

  has_many :posts
end