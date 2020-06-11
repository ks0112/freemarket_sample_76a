class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,password_length: 7..128

  validates :nickname, presence: true
  validates :family_name, presence: true
  validates :first_name, presence: true
  validates :family_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :birth_day, presence: true

  has_many :destinations, dependent: :destroy
  has_many :cards, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :selling_items, -> { where("seller_id is not NULL && buyer_id is NULL") }, class_name: "Item"
  has_many :bought_items, class_name: "Item", foreign_key: "buyer_id"
  has_many :sold_items, -> { where("buyer_id is not NULL") }, class_name: "Item"

  validate :password
  # 全角のバリデーション↓
  validate :name_em
  validate :name_kana_em
  # メールアドレスのバリデーション↓
  validate :valid_email?

  def valid_email?
    return if email.blank? || email =~ /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/
    # blank?はblankであれば"true"でblankでなければ"flase"を返す
    # ||は"または"であり左側が"false"なら右側を"return"する
    # つまり"email.blank?"が"false(ブランクではない)"場合、"email"を正規表現にかけるということになる
  end
  def password_complexity
    # Regexp extracted from https://stackoverflow.com/questions/19605150/regex-for-password-must-contain-at-least-eight-characters-at-least-one-number-a
    return if password.blank? || password =~ /^(?=.*?[a-zA-Z])(?=.*?[0-9]).{7,70}$/
    # blank?-値がない状態がture
    errors.add :password, "は英字と数字をそれぞれ1文字以上含める必要があります"
    # password.blank? || password =~ のどちらも"false"だからエラーになり、エラー表示される
  end

  def name_em
    if !(family_name =~ /^[ぁ-んァ-ン一-龥]/)
      if !(first_name =~ /^[ぁ-んァ-ン一-龥]/)
        errors.add :family_name, "は全角で入力してください"
        errors.add :first_name, "は全角で入力してください"
      else
        errors.add :family_name, "は全角で入力してください"
      end
    elsif !(first_name =~ /^[ぁ-んァ-ン一-龥]/)
      errors.add :first_name, "は全角で入力してください"
    else
      return
    end
  end

  def name_kana_em
    if !(family_name_kana =~ /^([ァ-ン]|ー)+$/)
      if !(first_name_kana =~ /^([ァ-ン]|ー)+$/)
        errors.add :family_name_kana, "は全角カタカナで入力してください"
        errors.add :first_name_kana, "は全角カタカナで入力してください"
      else
        errors.add :family_name_kana, "は全角カタカナで入力してください"
      end
    elsif !(first_name_kana =~ /^([ァ-ン]|ー)+$/)
      errors.add :first_name_kana, "は全角カタカナで入力してください"
    else
      return
    end
  end

end