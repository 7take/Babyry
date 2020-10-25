class BabiesController < ApplicationController
  def index
    @babies = Baby.all
  end

  def show
  	@baby = Baby.find(params[:id])
  end

  def new
  	@baby = Baby.new
  end

  def create
  	@baby = Baby.new(baby_params)
  	@baby.user_id = current_user.id
  	@baby.save
  	redirect_to baby_path(@baby)
  end

  def edit
    @baby = Baby.find(params[:id])
  end

  def update
    @baby = Baby.find(params[:id])
    @baby.update(baby_params)
    redirect_to baby_path(@baby)
  end

  def destroy
    baby = Baby.find(params[:id])
    baby.destroy
    redirect_to babies_path
  end

  private
  def baby_params
  	params.require(:baby).permit(:title, :body, :image)
  end
end
