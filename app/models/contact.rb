class Contact < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, uniqueness: true

  mount_base64_uploader :cover, AvatarUploader
end
