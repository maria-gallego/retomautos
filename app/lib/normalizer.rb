module Normalizer
  def self.normalize_phone(phone)
    phone.delete("^0-9")
  end

  def self.normalize_email(email)
    email.downcase.strip
  end
end