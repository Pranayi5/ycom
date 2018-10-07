class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :links ,dependent: :destroy
  has_many :comments, dependent: :destroy
  acts_as_voter

  after_create :fill_fake_data

  def fill_fake_data
    require 'faker'
    link_data
  end

  def link_data
    5.times do
      Link.create(title: Faker::Hacker.say_something_smart,
                  url: Faker::Internet.url,
                  user_id: self.id
      )
    end
  end
end
