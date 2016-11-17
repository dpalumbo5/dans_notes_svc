class User < ActiveRecord::Base
  has_many :notes
  has_many :notebooks
  has_one :auth_token
end
