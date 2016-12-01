module Voted
  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: [:like, :unlike]
  end

  def like
    @votable.liked_by current_user if !(current_user.author?(@votable))
  end

  def unlike
    @votable.downvote_from current_user if !(current_user.author?(@votable))
  end

  private

  def model_klass
    controller_name.classify.constantize
  end

  def set_votable
    @votable = model_klass.find(params[:id])
  end
end
