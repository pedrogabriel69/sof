class SearchesController < ApplicationController
  skip_authorization_check

  def index
  end

  def search
    type = params[:search][:type]
    value = params[:search][:value]
    if type == 'Global'
      @result = ThinkingSphinx.search value
    else
      @result = type.classify.constantize.search value
    end
  end
end
