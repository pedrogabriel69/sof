module Commented
  extend ActiveSupport::Concern

  private

  def model_klass
    params[:context].classify.constantize
  end

  def set_context
    return @commented = current_user if params[:context] == 'user'
    @commented = context_resource.find(params.fetch("#{params[:context].foreign_key}"))
    instance_variable_set("@#{params[:context]}", @commented)
  end
end
