require_relative '../tools/alchemyapi'
class Question
  include ActiveModel::Model
  attr_reader :text
  
  def self.keywords_for(text)
    new(text).keywords
  end
  
  def initialize(text='')
    @text = text
  end
  
  def keywords
    @keywords ||= build_keywords
  end
  
  def alchemyapi
    @alchemyapi ||= AlchemyAPI.new
  end  
  
  def build_keywords
    response = alchemyapi.keywords('text', text)
    raise 'Error in keyword extraction call: ' + response['statusInfo'] unless response['status'] == 'OK'
    response['keywords'].collect{|k| k['text']}
  end
end
