class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :items, through: :cart_items
  has_many :order_items

  validates :last_name,presence:true
  validates :first_name,presence:true
  validates :last_name_kana,presence:true
  validates :first_name_kana,presence:true
  validates :postcode,presence:true,length: { is: 7 }
  validates :phone_num,presence:true
  validates :address,presence:true

  #devise情報をパスワードなしで更新できるメソッド
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end

  # enumの設定
  enum is_deleted: { withdraw: true, active: false}

  # フルネーム（nilの場合を除く）
  def full_name
    self.last_name + self.first_name
  end

  # フルネーム（姓名の間にスペースあり）（nilの場合を除く）
  def show_full_name
    self.last_name + " " + self.first_name
  end

  # フルネームカナ（nilの場合を除く）
  def full_name_kana
    self.last_name_kana + " " + self.last_name_kana
  end

  has_many :orders, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :cart_items, dependent: :destroy

end
