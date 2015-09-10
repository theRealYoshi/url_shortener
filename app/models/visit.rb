# == Schema Information
#
# Table name: visits
#
#  id         :integer          not null, primary key
#  visitor_id :integer          not null
#  url_id     :integer          not null
#  created_at :datetime
#  updated_at :datetime
#

class Visit < ActiveRecord::Base
  belongs_to(
    :visitor,
    :class_name => "User",
    :foreign_key => :visitor_id,
    :primary_key => :id
  )

  belongs_to(
    :visited_url,
    :class_name => "ShortenedUrl",
    :foreign_key => :url_id,
    :primary_key => :id
  )

  def self.record_visit!(user, shortened_url)
    url_id = ShortenedUrl.find_by_short_url(shortened_url).id
    user.visits.create(:url_id => url_id)
  end

end
