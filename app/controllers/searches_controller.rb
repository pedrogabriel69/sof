class SearchesController < ApplicationController
  skip_authorization_check

  def index; end

  def search
    type = params[:search][:type]
    value = params[:search][:value]

    @result = if type == 'Global'
                ThinkingSphinx.search ThinkingSphinx::Query.escape(value)
              else
                type.classify.constantize.search ThinkingSphinx::Query.escape(value)
              end
  end
end
