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

  has_many :visitors, :through => :visits, :source => :visitor

  validates :short_url, presence: true, uniqueness: true

  def self.random_code
    secure = nil
    while exists?(:short_url => secure) || secure.nil?
      secure = SecureRandom::urlsafe_base64.slice(0,16)
    end
    secure
  end

  def self.create_for_user_and_long_url!(user, long_url)
    user.submitted_urls.create(:long_url => long_url,
                              :short_url => random_code)
  end


end
