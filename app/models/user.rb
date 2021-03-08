class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :user_name, :email

  def first_name             
    self.name.split.first
  end

  def last_name
    self.name.split.last
  end

  has_many :tweets
  has_many :comments
end
