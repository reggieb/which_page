require 'ferret'
class Search 
  
  def self.for(text)
    new.search(text)
  end
  
  def self.path_to_index
    File.expand_path('data/ferret', Rails.root)
  end
  
  def self.index
    @index ||= Ferret::Index::Index.new(path: path_to_index)
  end
  
  def index
    self.class.index
  end
  
  def add_source_page(source_page)
    index << {
      id: source_page.id,
      content: source_page.content
    }
  end
  
  def search(text)
    output = {}
    index.search_each("content:\"#{text}\"") do |id, score| 
      output[SourcePage.find(id)] = score if SourcePage.exists?(id)
    end
    output
  end
end
