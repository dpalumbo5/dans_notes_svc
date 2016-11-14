class AuthToken < ActiveRecord::Base
  belongs_to :user

  def self.generate_token
    (0...8).map { (65 + rand(26)).chr }.join
  end
end
