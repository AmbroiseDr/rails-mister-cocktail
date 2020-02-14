class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.all
    @cocktail_random = Cocktail.order('random()').first
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @cocktail_random = Cocktail.order('random()').first
  end

  def new
    @cocktail = Cocktail.new
    @dose = Dose.new
    @cocktail_random = Cocktail.order('random()').first
  end

  def create
    @cocktail = Cocktail.new(params_cocktails)
    if @cocktail.save
      redirect_to new_cocktail_dose_path(@cocktail)
    else
      render :new
    end
  end

  private

  def params_cocktails
    params.require(:cocktail).permit(:description, :name)
  end
end
