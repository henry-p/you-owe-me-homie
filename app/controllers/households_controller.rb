class HouseholdsController < ApplicationController
  def new
    @household= Household.new
  end

  def create
    @household = Household.new(household_params)

    if @household.save
      @household.users << current_user
      redirect_to household_path(@household)
    else
      render 'new'
    end
  end

  def show
    @household = Household.find_by(id: params[:id])
  end

  private

  def household_params
    params.permit(:name, :address)
  end


end
