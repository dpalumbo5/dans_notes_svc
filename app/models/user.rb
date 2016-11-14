class User < ActiveRecord::Base
  has_many :notes
  has_many :notebooks
end
