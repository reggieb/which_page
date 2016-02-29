require 'net/http'
require_relative '../tools/alchemyapi'
class SourcePage < ActiveRecord::Base
  has_many :keywords
  after_save :build_keywords
  
  validates :url, presence: true, uniqueness: true
  
  def build_keywords
    keywords.delete_all
    response = alchemyapi.keywords('html', body)
    raise 'Error in keyword extraction call: ' + response['statusInfo'] unless response['status'] == 'OK'
    response['keywords'].each do |keyword_params|
      keywords.find_or_create_by keyword_params
    end
  end
  
  def alchemyapi
    @alchemyapi ||= AlchemyAPI.new
  end
  
  def body
    @body ||= Net::HTTP.get(uri)
  end
  
  def uri
    @uri ||= URI(url)
  end
  
end
