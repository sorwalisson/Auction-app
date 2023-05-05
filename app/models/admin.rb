class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, :cpf, :validation_code, presence: true
  validates :cpf, uniqueness: true
  validate :verify_admin_code
  validate :verify_email
  validates_with CpfValidator

  def verify_admin_code
    existing_code = ["XYZ105BYZ55", "XCC202BYZ60", "BYABGG521UA"]
    if existing_code.include?(self.validation_code) == false
      self.errors.add(:validation_code, "it is not a valid code")
    end
  end

  def verify_email
    if self.email.match?("leilaodogalpao.com.br") == false then self.errors.add(:email, "It is not a admin email") end
  end

end
