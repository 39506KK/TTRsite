class Customer < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :last_name, :first_name, :tell, presence: true
  validates :password, presence: true, length: { minimum: 6 },
            # 英数字のみ可
            format: { with: /\A[a-z0-9]+\z/i, message: "は英数字以外の文字を含めることはできません。" }, on: create
  validates :email, presence: true,
            # 重複不可
            uniqueness: { case_sensitive: false }, 
            # 英数字のみ可,@を挟んだemailの形になっているか
            # /^\S+@\S+\.\S+$/   /\A[a-z0-9]+\z/i  /^[a-zA-Z0-9]+$/
            format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: "は例の様な形式になっていないか、英数字以外の文字を含めることはできません。" }
  validates :first_kana, :last_kana, presence: true,
            # カナのみ可
            format: { with: /\A([ァ-ン]|ー)+\z/, message: "はカナ以外の文字を含めることはできません。" }
  validates :tell, presence: true,
            # 数字のみ可
            format: { with: /\A[0-9]+\z/i, message: "は数字以外の文字を含めることはできません。" }
  
  # is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_deleted == false)
  end
  
  has_many :reserves, dependent: :destroy
  
  def full_name
    "#{first_name} #{last_name}" 
  end
  
end
