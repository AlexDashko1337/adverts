class CommentSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :advert_id, :context
  has_one :advert
  has_one :user
end
