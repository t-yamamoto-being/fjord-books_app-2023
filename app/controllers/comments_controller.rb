# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentable

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @commentable, notice: t('controllers.comments.notice_create')
    else
      flash.now[:alert] = @comment.errors.full_messages.join(', ')
      render 'reports/show'
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])
    
    if @comment.user == current_user
      @comment.destroy
      redirect_to @commentable, notice: t('controllers.comments.notice_destroy')
    else
      redirect_to @commentable, alert: t('controllers.comments.notice_unauthorized')
    end
  end

  private

  def set_commentable
    @commentable = Report.find(params[:report_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end 