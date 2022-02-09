class AdvertSerializer < ActiveModel::Serializer
  attributes :id, :context
  has_many :comments
  has_one :user

  #attribute link :custom_url do |object|
    #"127.0.0.1:3000/users/#{object.user_id}/adverts/#{object.id}"
  #end

end
