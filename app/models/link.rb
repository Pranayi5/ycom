class Link < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable,dependent: :destroy
  acts_as_votable
end
