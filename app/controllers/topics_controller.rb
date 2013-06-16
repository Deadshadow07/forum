# -*- encoding : utf-8 -*-
class TopicsController < ApplicationController
  # GET /topics
  # GET /topics.json
  before_filter :not_authenticated, :except => [:index]
  before_filter :require_login, except: [:index, :show]
  before_filter :check_edit, only: [:edit, :update, :destroy, :block, :unblock]
  before_filter :check_show, only: :show
  def index
    @topics = Topic.order('updated_at DESC').page(params[:page])
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    @topic = Topic.includes(:posts => {:user => :setting}).find(params[:id])
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    @topic = Topic.new(params[:topic])
    if @topic.save
      redirect_to @topic,notice: 'Тема создана'
    else
      render 'new'
    end

    #respond_to do |format|
    #  if @topic.save
    #    format.html { redirect_to @topic, notice: 'Topic was successfully created.' }
    #    format.json { render json: @topic, status: :created, location: @topic }
    #  else
    #    format.html { render action: "new" }
    #    format.json { render json: @topic.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

      if @topic.update_attributes(params[:topic])
        redirect_to @topic, notice: 'Тема изменена.'
      else
        render action: "edit"
      end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.destroy

    redirect_to topics_path
  end
  def block
    @topic.blocked=true
    @topic.save
    flash[:success]="Топик заблокирован"
    redirect_to @topic
  end
  def unblock
    @topic.blocked=false
    @topic.save
    flash[:success]="Топик раблокирован"
    redirect_to @topic
  end
  private
    def check_edit
      @topic=Topic.find(params[:id])
      unless @topic.edit?(current_user)
        error_message
      end
    end
  private
  def check_show
    @topic=Topic.find(params[:id])
    if !@topic.edit?(current_user) && @topic.blocked?
      error-message("Топик заблокирован")
    end
  end
end
