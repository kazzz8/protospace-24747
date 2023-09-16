class Prototype < ApplicationRecord
  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :user, presence: true
  validates :image, presence: true

  belongs_to :user
  has_one_attached :image
  #has_one_attached :ファイル名
  #各レコードとファイルを1対1の関係で紐付けるメソッド

  has_many :comments, dependent: :destroy
  #dependent: :destroyオプションは親モデルのレコードが削除された際、連動して一緒に子モデルのレコードを削除するオプション
  #今回でいうとprototypeが削除されたときにそれに対するcommentsを削除する
end
