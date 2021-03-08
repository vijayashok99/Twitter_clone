class Like < ApplicationRecord
  validates_presence_of :user_id, :likeable_type, :likeable_id

  after_create :increase_like_count
  after_destroy :decrease_like_count

  belongs_to :likeable, polymorphic: true

  def increase_like_count
    record = get_parent_record()
    record.update!(likes_count: record.likes_count + 1)
  end

  def decrease_like_count
    record = get_parent_record()
    record.update!(likes_count: record.likes_count - 1)
  end

  def get_parent_record
    if self.likeable_type == 'Tweet'
      record = Tweet.find_by_id(self.likeable_id)
    elsif self.likeable_type == 'Comment'
      record = Comment.find_by_id(self.likeable_id)
    end
    return record
  end
end
