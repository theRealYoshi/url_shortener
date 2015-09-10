# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  has_many(
    :submitted_urls,
    :class_name => 'ShortenedUrl',
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :visitor_id,
    :primary_key => :id
  )

  has_many(
    :visited_urls,
    Proc.new { distinct },
    :through => :visits,
    :source => :visited_url
  )

  validates :email, presence: true, uniqueness: true

  def create_short_url(long_url)
    unless premium
      if count_submitted_urls > 5
        fails "You've submited way too many urls. Sign up for premium!"
      end
    end

    ShortenedUrl.create_for_user_and_long_url!(self, long_url)
  end

  private

  def count_submitted_urls
    submitted_urls.count
  end
end
