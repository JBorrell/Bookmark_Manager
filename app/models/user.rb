require 'dm-validations'

class User
  include DataMapper::Resource

  property :id,       Serial
  property :name,     String
  property :email,    Text, :required => true, :format => :email_address
  property :password, BCryptHash, length: 255
  attr_accessor :password_confirmation

  validates_confirmation_of :password,
    :message => "Password and confirmation password do not match"

  validates_uniqueness_of :email,
    :message => "Email address already registered"

  has n, :links, through: Resource
  
end
