class User < ApplicationRecord
  include SecureTokens
  
  has_secure_password
  has_secure_tokens
end
