class Pet < ApplicationRecord
  SPECIES = %w[dog cat rabbit bird reptile other].freeze

  belongs_to :owner
  has_many :appointments, dependent: :destroy
  has_one_attached :photo

  before_save :capitalize_name

  validates :name, presence: true
  validates :species, presence: true, inclusion: { in: SPECIES }
  validates :date_of_birth, presence: true
  validates :weight, presence: true, numericality: { greater_than: 0 }
  validates :owner, presence: true

  validate :date_of_birth_cannot_be_in_the_future
  validate :photo_must_be_valid_image

  scope :by_species, ->(species) { where(species: species.to_s.downcase) }

  private

  def date_of_birth_cannot_be_in_the_future
    return if date_of_birth.blank?
    return unless date_of_birth > Date.current

    errors.add(:date_of_birth, "can't be in the future")
  end

  def capitalize_name
    self.name = name.to_s.strip.titleize
  end

  def photo_must_be_valid_image
    return unless photo.attached?

    unless photo.content_type.in?(%w[image/png image/jpg image/jpeg])
      errors.add(:photo, 'must be a PNG, JPG, or JPEG file')
    end
    if photo.byte_size > 5.megabytes
      errors.add(:photo, 'size must be less than 5MB')
    end
  end
end