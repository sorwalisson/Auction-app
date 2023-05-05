class CpfValidator < ActiveModel::Validator
  
  def validate(record)
    if record.cpf.length != 11 then record.errors.add(:cpf, "CPF must be 11 digits only") end
    if record.cpf.length == 11
      if verify_cpf(record.cpf) == false then record.errors.add(:cpf, "must be valid") end
    end
  end
  
  def verify_cpf(cpf)
    cpf = cpf.split('')
    if cpf.count(cpf.first) == 11 then return false end
    d1 = cpf.fetch(9).to_i
    d2 = cpf.fetch(10).to_i
    index = 0
    multiplicador = 10
    resultado = 0
    cpf.map do |i|
      if index <= 8
        resultado += i.to_i * multiplicador
        index += 1
        multiplicador -= 1
      end
    end
    resto = resultado % 11
    if resto == 0 or resto == 1
      return false unless d1 == 0
    else
      return false unless 11 - resto == d1
    end
    index = 0
    multiplicador = 11
    resultado = 0
    cpf.map do |i|
      if index <= 9
        resultado += i.to_i * multiplicador
        index += 1
        multiplicador -= 1
      end
    end
    resto = resultado % 11
    if resto == 0 or resto == 1
      return false unless d2 == 0
      return true
    else
      return false unless 11 - resto == d2
      return true
    end
  end
end