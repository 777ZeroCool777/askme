class Question < ActiveRecord::Base

  belongs_to :user

  validates :text, :user, presence: true
  validates :text, length: {maximum: 255}

  validates :text, :user, presence: true

  belongs_to :questioning_user, class_name: 'User'

end
