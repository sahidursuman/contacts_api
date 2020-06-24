class Contact < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, uniqueness: true

  mount_base64_uploader :avatar, AvatarUploader

  scope :most_recent, -> { order('updated_at DESC') }

  class << self 
    def find_by_timestamp timestamp
      raise ArgumentError unless timestamp.present?
      # where("created_at <= ? OR updated_at <= ?", timestamp, timestamp)
      # .order('updated_at DESC, created_at DESC')
      where("updated_at <= ?", timestamp)
      .order('updated_at DESC')
    end
  end
end
