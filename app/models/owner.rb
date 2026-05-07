class Owner < ApplicationRecord
    has_many :pets

    before_validation :normalize_email

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :email,
                presence: true,
                format: { with: URI::MailTo::EMAIL_REGEXP },
                uniqueness: { case_sensitive: false }
    validates :phone, presence: true

    private

    def normalize_email
        self.email = email.to_s.strip.downcase
    end
end
