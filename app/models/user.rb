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
  has_many :visited_urls, :through => :visits, :source => :visited_url

  validates :email, presence: true, uniqueness: true


end
