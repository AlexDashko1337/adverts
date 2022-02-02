class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :jwt_authenticatable, jwt_revocation_strategy: JwtBlacklist

  has_many :comments, :dependent => :destroy
  has_many :adverts, :dependent => :destroy

  enum role: %i[ newbie moderator admin ] 

end
