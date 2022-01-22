class UsersSerializer < ActiveModel::Serializer
  attributes :id, :firstname, :lastname
  has_many :adverts
end
