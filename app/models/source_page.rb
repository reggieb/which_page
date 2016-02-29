require 'net/http'
require_relative '../tools/alchemyapi'
class SourcePage < ActiveRecord::Base
  has_many :keywords
  after_save :build_keywords
  
  validates :url, presence: true, uniqueness: true
  
  def build_keywords
    keywords.delete_all
    response = alchemyapi.combined('url', url, { 'extract'=>'page-image,keyword,entity' })
    raise 'Error in combined extraction call: ' + response['statusInfo'] unless response['status'] == 'OK'
    result = (response['keywords'] || []) + (response['entities'] || []).collect{|e| e.slice('text', 'relevance')}
    result.each do |params|
      keywords.find_or_create_by(text: params['text']) do |keyword|
        keyword.relevance = params['relevance'].to_f if !keyword.relevance? || keyword.relevance < params['relevance'].to_f
      end
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
