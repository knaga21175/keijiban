class User < ApplicationRecord

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i  #メールアドレスのパターンを定数に格納

  validates :roomno, 
        presence: false
        length: { minimum: 2 }
        :only_integer true
  validates :email, 
        presence: true, 
        format: { with: VALID_EMAIL_REGEX, message: "が適切ではありません"}
        uniqueness: true
end
