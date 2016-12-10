module Commented
  extend ActiveSupport::Concern

  private

  def model_klass
    params[:context].classify.constantize
  end

  def set_commented
    return @commented = current_user if params[:context] == 'user'
    @commented = model_klass.find(params.fetch(params[:context].foreign_key.to_s))
    instance_variable_set("@#{params[:context]}", @commented)
  end
end
