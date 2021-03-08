class Comment < ApplicationRecord
  validates_presence_of :comment, :user_id, :tweet_id
  validates :comment_count, numericality: {greater_than_or_equal_to: 0}
  validates :likes_count, numericality: {greater_than_or_equal_to: 0}

  default_scope { order('created_at desc') }

  after_create :increase_reply_count
  after_destroy :decrease_reply_count

  belongs_to :user
  belongs_to :tweet
  has_many :likes, as: :likeable, dependent: :destroy

  def increase_reply_count
    record = get_parent_record()
    record.update!(comment_count: record.comment_count + 1)
  end

  def decrease_reply_count
    record = get_parent_record()
    record.update!(comment_count: record.comment_count - 1)
  end

  def get_parent_record
    if self.parent_comment_id.nil?
      record = Tweet.find_by_id(self.tweet_id)
    else
      record = Comment.find_by_id(self.parent_comment_id)
    end
    return record
  end

end
