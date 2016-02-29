class QuestionsController < ApplicationController
  def index
  end
  
  def create
    @text = params[:question][:text]
    @question = Question.new(@text)
    criteria = @question.keywords.flatten.uniq.collect{|k| "%#{k}%"}
    keyword = Keyword.arel_table
    @source_pages = SourcePage.joins(:keywords)
                           .where(keyword[:text].matches_any(criteria))
                           .where(keyword[:relevance].gt(0.5))
                           .order(keyword[:relevance])
                           .uniq
    render :index
    
  end
end
