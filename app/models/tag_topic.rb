class TagTopic < ActiveRecord::Base
  has_many(
    :tags,
    :class_name => 'Tag',
    :foreign_key => :tag_id,
    :primary_key => :id
  )

  has_many(
    :urls,
    :through => :tags,
    :source => :url
  )

end
