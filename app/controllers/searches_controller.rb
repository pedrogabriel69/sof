class SearchesController < ApplicationController
  skip_authorization_check

  def index; end

  def search
    type = params[:search][:type]
    unchecked = params[:search][:value]
    value = unchecked.include?('@') ? check_spelling(unchecked) : unchecked

    @result = if type == 'Global'
                ThinkingSphinx.search value
              else
                type.classify.constantize.search value
              end
  end

  private

  # here, cuz I don't have model search
  def check_spelling(text)
    text.gsub!('@', '\\' + '@')
  end
end
