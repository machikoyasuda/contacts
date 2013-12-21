class Contact < ActiveRecord::Base
  validates :firstname, :lastname, presence: true
  validates :email_address, uniqueness: true

  def name
    [firstname, lastname].join(" ")
  end

  class << self
    # instead of self.by_letter
    def by_letter(letter)
      # where SQL, string interpolation + wildcard
      where("lastname LIKE ?", "#{letter}%").order(:lastname)
    end
  end

end