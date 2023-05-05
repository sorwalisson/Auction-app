class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :cpf, :zip, :address, presence: true
  validates :cpf, uniqueness: true
  validates_with CpfValidator
  validates_with ZipValidator
  validate :set_admin_or_user


  def set_admin_or_user
    if self.email.match?("@leilaodogalpao.com.br") then self.admin = true end
  end

  def description
    "#{self.name} - #{self.email}"
  end
end
