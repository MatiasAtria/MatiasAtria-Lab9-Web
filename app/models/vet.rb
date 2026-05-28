class Vet < ApplicationRecord
  belongs_to :user, optional: true
  has_many :appointments, dependent: :destroy

  before_validation :normalize_email

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
            presence: true,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: { case_sensitive: false }
  validates :specialization, presence: true
  validates :user_id, uniqueness: true, allow_nil: true

  scope :by_specialization, ->(specialization) { where(specialization: specialization) }

  private

  def normalize_email
    self.email = email.to_s.strip.downcase
  end
end