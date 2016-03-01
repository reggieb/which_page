require 'bronto'

class Thesaurus
  
  attr_reader :word
  
  def self.nouns_matching(word)
    [word] + new(word).nouns
  end
  
  def initialize(word)
    @word = word
  end
  
  def lookup
    @lookup ||= bronto.lookup word
  end
  
  def nouns
    (lookup && lookup[:noun]) ? lookup[:noun][:syn] : []
  end
  
  def verbs
    (lookup && lookup[:verb]) ? lookup[:verb][:syn] : []
  end
  
  def bronto
    @bronto ||= Bronto::Thesaurus.new
  end
end
