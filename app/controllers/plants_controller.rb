# encoding: utf-8
class PlantsController < ApplicationController

  def index
    @plants = Plant.all

    respond_to do |format|
      format.html
      format.json { render :json => @plants }
    end
  end

  def show
    @plant = Plant.find(params[:id])

    respond_to do |format|
      format.html
      format.json { render :json => @plant }
    end
  end


  def new
    @plant = Plant.new
    respond_to do |format|
      format.html
      format.json { render :json => @plant }
    end
  end

  def edit
    #[["phylum_name","门",0],["sub_phylum_name","门",1],["pclass_name","纲",0],["sub_pclass_name","纲",0],["porder_name","目",0],['genus_name','属',0]]
    # @sub_phylum_name = Hash[PlantBaseInfo.sub_phylum_name]
    # @pclass_name = Hash[PlantBaseInfo.pclass_name]
    # @sub_pclass_name = Hash[PlantBaseInfo.sub_pclass_name]
    # @porder_name = Hash[PlantBaseInfo.porder_name]
    # @genus_name = Hash[PlantBaseInfo.genus_name]
    @phylum_name = PlantBaseInfo.format_phylum_name
    @plant = Plant.find(params[:id])
    @phylum_name = plant_base_info.find(params[:phylum_name])
  end

  def create
    plant = Plant.new
    version_id = plant.update_by_params_data(params)
    plant.save

    unless params[:filedata].blank?
      picture = Picture.create_picture(params[:filedata])
      plant.pictures << picture
    end
    redirect_to edit_plant_path(plant, :version_id => version_id) 
  end

  def update
    plant = Plant.find(params[:id])
    params[:plant][:user_id] = User.first.id

    plant.update_by_params_data(params[:plant],params[:version_id])
    plant.save
    redirect_to plants_path
  end

  def destroy
    @plant = Plant.find(params[:id])
    @plant.destroy
    redirect_to plants_path
  end

end
