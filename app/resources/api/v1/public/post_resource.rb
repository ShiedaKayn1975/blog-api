class Api::V1::Public::PostResource < JSONAPI::Resource
  attributes :id, :title, :status, :content, :brief, :created_at, :updated_at, :tags

  has_many :tags

  def tags
    @model.tags.as_json
  end
end