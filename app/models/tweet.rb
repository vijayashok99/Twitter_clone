class Tweet < ApplicationRecord
	enum status: [:DRAFT, :PUBLISHED, :DISCARDED]

  validates_length_of :tweet, :within => 1..280, :too_long => "Tweet length exeeded", :if => Proc.new { |tweet| tweet.tweet.present? }
  validates_presence_of :user_id
  validates :comment_count, numericality: {greater_than_or_equal_to: 0}
  validates :likes_count, numericality: {greater_than_or_equal_to: 0}

  default_scope {order('created_at desc')}

  mount_uploader :image_url, TweetImageUploader

  belongs_to :user
  has_many :comments
  has_many :likes, as: :likeable, dependent: :destroy
end
