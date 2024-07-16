class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless URI::MailTo::EMAIL_REGEXP.match?(value)
      record.errors.add attribute, (options[:message] || "is not an email")
    end
  end
end

class User < ApplicationRecord
  has_many :following
  has_many :follows, through: :following, class_name: "User", foreign_key: "follow_id"

  validates :username, presence: true
  validates :username, length: {minimum: 4, maximum: 30}
  validates :email, presence: true
  validates :email, email: true
  validates :password, presence: true
  validates :password, length: {minimum: 8}
end
