# -*- encoding : utf-8 -*-
class SettingsController < ApplicationController
  # GET /settings
  # GET /settings.json
  def index
    @setting = Setting.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @setting }
    end
  end

  def show
    @setting = Setting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @setting }
    end
  end


  # GET /settings/1/edit
  def edit
   @setting = Setting.where(:user_id=>current_user.id).first
  end
  def new
    @setting = Setting.new
  end
  # POST /settings
  # POST /settings.json
  def create
    @setting = Setting.new(params[:setting])
    @setting.user_id=current_user.id

    respond_to do |format|
      if @setting.save
        format.html { redirect_to @setting, notice: 'Setting was successfully created.' }
        format.json { render json: @setting, status: :created, location: @setting }
      else
        format.html { render action: "new" }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /settings/1
  # PUT /settings/1.json
  def update
    @user=current_user
    @setting = Setting.where(:user_id=>current_user.id).first
      if @setting.update_attributes(params[:setting])
        redirect_to profile_path, :notice => "Изменения применены"
      else
    flash[:error] = "Не сохранено"
    render 'edit'
      end
  end


  # DELETE /settings/1
  # DELETE /settings/1.json
  def destroy
    @setting = @user.setting.find(params[:id])
    @setting.destroy

    respond_to do |format|
      format.html { redirect_to settings_url }
      format.json { head :no_content }
    end
  end
end
