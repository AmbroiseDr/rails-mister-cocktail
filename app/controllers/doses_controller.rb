class DosesController < ApplicationController

  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
    @cocktail_random = Cocktail.order('random()').first
  end

  def create
    @dose = Dose.new(review_params)
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose.cocktail=@cocktail
    if @dose.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
      raise
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    @dose.destroy
    redirect_to cocktail_path(@dose.cocktail)
  end

  private

  def review_params
    params.require(:dose).permit(:ingredient_id, :description, :order)
  end
end
