class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  validates :date_of_birth, presence: true

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates_format_of :password, with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください'

  with_options presence: true do
    validates :last_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, allow_blank: true, message: '全角文字を使用してください' }
    validates :first_name, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, allow_blank: true, message: '全角文字を使用してください' }
  end

  with_options presence: true do
    validates :last_name_kana, format: { with: /\A[ァ-ヶー]+\z/, allow_blank: true, message: '全角カタカナを使用してください' }
    validates :first_name_kana, format: { with: /\A[ァ-ヶー]+\z/, allow_blank: true, message: '全角カタカナを使用してください' }
  end
  
  has_many :items
  #has_many :orders
end
