class Announcement < ActiveRecord::Base

  # Associations
  belongs_to :user

  # Strip leading and trailing whitespace from attributes
  auto_strip_attributes :title, :body

  # Save emails in lowercase
  before_save { prefix_link }

  # Verifying title exists
  validates :title,
    presence: { message: 'Your announcement must have a title.' },
    length: { maximum: 255, too_long: 'Title can be a maximum %{count} characters.' }

  # Verifying announcement exists
  validates :body,
    presence: { message: 'You cannot submit a blank announcement.' },
    length: { maximum: 255, too_long: 'Body can be a maximum %{count} characters.' }

  # Adds http:// to a link if it is missing
  def prefix_link
    if self.link && self.link.length > 0
      unless self.link.starts_with?('http')
        self.link = 'http://' + self.link
      end
    end
  end

end
