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
  has_many :auction_lots


  def set_admin_or_user
    if self.email.match?("@leilaodogalpao.com.br") then self.admin = true end
  end

  def description
    "#{self.name} - #{self.email}"
  end

  def full_description
    "#{self.name} - #{self.email}"
  end

  def cpf_checker
    block = BlackListCpf.find_by(cpf: self.cpf)
    if block.present? then return true end
    return false
  end
end
