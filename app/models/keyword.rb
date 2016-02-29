class Keyword < ActiveRecord::Base
  belongs_to :source_page
  delegate :url, to: :source_page
end
