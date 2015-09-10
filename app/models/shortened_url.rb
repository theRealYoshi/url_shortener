# == Schema Information
#
# Table name: shortened_urls
#
#  id           :integer          not null, primary key
#  long_url     :string           not null
#  short_url    :string           not null
#  submitter_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class ShortenedUrl < ActiveRecord::Base
  belongs_to(
    :submitter,
    :class_name => 'User',
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

  has_many(
    :visits,
    :class_name => "Visit",
    :foreign_key => :url_id,
    :primary_key => :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    :through => :visits,
    :source => :visitor
  )

  has_many(
    :tags,
    :class_name => 'Tag',
    :foreign_key => :url_id,
    :primary_key => :id,
    dependent: :destroy
  )

  has_many :tag_topics, :through => :tags, :source => :tag_topic

  validates :short_url, presence: true, uniqueness: true
  validates :long_url, length: { maximum: 1024 }

  def self.random_code
    secure = nil
    while exists?(:short_url => secure) || secure.nil?
      secure = SecureRandom::urlsafe_base64.slice(0,16)
    end
    secure
  end

  def self.create_for_user_and_long_url!(user, long_url)
    url = random_code
    user.submitted_urls.create(:long_url => long_url,
                              :short_url => url)
    url
  end

  def self.prune(n)
    where({created_at: (n.minutes.ago..Time.now)}).destroy_all
  end

  def num_clicks
    visits.select('visitor_id').count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.select('visitor_id').distinct.where({ created_at: (10.minutes.ago..Time.now) })
  end
end
