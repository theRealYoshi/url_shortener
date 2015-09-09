# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


5.times do |i|
  User.create(:email => "user_#{i}@example.com")
end

ShortenedUrl.create(:long_url => 'www.google.com', :short_url => 'fjdsa;lfja', :submitter_id => 1)
ShortenedUrl.create(:long_url => 'www.facbook.com', :short_url => '______;lfja', :submitter_id => 1)
ShortenedUrl.create(:long_url => 'www.youtube.com', :short_url => '!!!!!!;lfja', :submitter_id => 2)


Visit.create(:visitor_id => 1, :url_id => 1)
Visit.create(:visitor_id => 1, :url_id => 2)
Visit.create(:visitor_id => 2, :url_id => 2)
Visit.create(:visitor_id => 2, :url_id => 1)
Visit.create(:visitor_id => 3, :url_id => 1)
