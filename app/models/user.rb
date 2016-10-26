class User < ActiveRecord::Base
    attr_accessor :remember_token
    # email属性を小文字に変換してメールアドレスの一意性を保証
    before_save {email.downcase!}
    # name属性の存在性を検証
    validates :name, presence: true, length: {maximum: 50}
    # validates(:name, presence: true)
    # メールフォーマットを正規表現で検証
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    # email属性の存在性を検証
    # メールアドレスの一意性を検証
    validates :email, presence: true, length: {maximum: 255},
                format: {with: VALID_EMAIL_REGEX},
                uniqueness: {case_sensitive: false}
    has_secure_password
    validates :password, presence: true, length: {minimum: 6}

    # 与えられた文字列のハッシュ値を返す
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ?
        BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # ランダムなトークンを返す
    def User.new_token
        SecureRandom.urlsafe_base64
    end

    # 永続的セッションで使用するユーザーをデータベースに記憶
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
end
