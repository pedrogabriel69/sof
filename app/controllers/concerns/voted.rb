module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: [:like, :unlike]
  end

  def like
    instance_variable_set("@#{controller_name.singularize}", @votable).liked_by current_user if !(current_user.author?(instance_variable_set("@#{controller_name.singularize}", @votable)))
  end

  def unlike
    instance_variable_set("@#{controller_name.singularize}", @votable).downvote_from current_user if !(current_user.author?(instance_variable_set("@#{controller_name.singularize}", @votable)))
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def set_votable
    @votable = model_klass.find(params[:id])
  end
end
