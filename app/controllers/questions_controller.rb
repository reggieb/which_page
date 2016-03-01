class QuestionsController < ApplicationController
  def index
  end
  
  def create
    @text = params[:question][:text]
    @question = Question.new(@text)
    @criteria = @question.combined.flatten.uniq.collect{|k| k['text']}.uniq
    @source_pages = if @question.combined.present?
      keyword = Keyword.arel_table
      SourcePage.joins(:keywords)
                .where(keyword[:text].matches_any(@criteria.collect{|k|"%#{k}%"}))
                .order(keyword[:relevance])
                .uniq
    else
      []
    end
    @search = Search.for @criteria
    @fuzzy_words = @criteria.collect{|c| Thesaurus.nouns_matching(c)}.flatten
    @fuzzy_search = Search.for @fuzzy_words
    render :index
    
  end
end
