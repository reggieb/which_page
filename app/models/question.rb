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
  
  def concepts
    @concepts ||= build_concepts
  end
  
  def combined
    @combined ||= build_combined
  end
  
  def alchemyapi
    @alchemyapi ||= AlchemyAPI.new
  end  
  
  def build_keywords
    response = alchemyapi.keywords('text', text)
    raise 'Error in keyword extraction call: ' + response['statusInfo'] unless response['status'] == 'OK'
    response['keywords'].collect{|k| k['text']}
  end
  
  def build_concepts
    response = alchemyapi.concepts('text', text)
    raise 'Error in concept extraction call: ' + response['statusInfo'] unless response['status'] == 'OK'
    response['concepts'].inspect
  end
  
  def build_combined
    response = alchemyapi.combined('text', text, { 'extract'=>'page-image,keyword,entity' })
    raise 'Error in combined extraction call: ' + response['statusInfo'] unless response['status'] == 'OK'
    (response['keywords'] || []) + (response['entities'] || []).collect{|e| e.slice('text', 'relevance')}
  end
end
