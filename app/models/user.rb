class User < ActiveRecord::Base
    # email属性を小文字に変換してメールアドレスの一意性を保証
    before_save {self.email = email.downcase}
    # name属性の存在性を検証
    validates :name, presence: true, length: {maximum: 50}
    # validates(:name, presence: true)
    # メールフォーマットを正規表現で検証
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    # email属性の存在性を検証
    # メールアドレスの一意性を検証
    validates :email, presence: true, length: {maximum: 255},
                format: {with: VALID_EMAIL_REGEX},
                uniqueness: {case_sensitive: false}
    has_secure_password
    validates :password, presence: true, length: {minimum: 6}
end
