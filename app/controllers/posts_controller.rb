# -*- encoding : utf-8 -*-
class PostsController < ApplicationController
  # GET /posts
  # GET /posts.json
  before_filter :load_topic
  before_filter :require_login, except:[:index,:show]
  before_filter :check_edit, only:[:edit,:update,:destroy]
  def edit
    @post = @topic.posts.find(params[:id])
  end
      # POST /posts
  # POST /posts.json                                                nder
  def create
    @post = @topic.posts.new(params[:post])
    @post.user=current_user
    if @post.save
      redirect_to @topic,notice: 'Сообщение сохранено'
    else
      render :text => params[:post].inspect
    end

  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = @topic.posts.find(params[:id])
      if @post.update_attributes(params[:post])
        redirect_to @topic, notice: 'Сообщение отредактирово'
      else
        render action: "edit"
      end
    end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = @topic.posts.find(params[:id])
    @post.destroy
    redirect_to topic_path(@topic)
    end
  private
    def load_topic
      @topic=Topic.find(params[:topic_id])
    end
  private
  def check_edit
    @post=@topic.posts.find(params[:id])
    unless @post.edit?(current_user)
      error_message
    end
  end
end
