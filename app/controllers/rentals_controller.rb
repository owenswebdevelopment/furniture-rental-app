class RentalsController < ApplicationController
  def index
    @rentals = current_user.rentals
    # @rentals_as_owner = Rental.for_owner(current_user)
  end

  def create
    @furniture = Furniture.find(params[:furniture_id])
    @rental = Rental.new(rental_params)
    @rental.furniture = @furniture
    @rental.user = current_user
    dates = params[:rental][:start_date].split(' to ')
    @rental.start_date = dates.first
    @rental.end_date = dates.last
    @rental.status = 0
    if @rental.save
      redirect_to rentals_path, notice: 'Saved Successfully'
    else
      render 'furnitures/show', status: :unprocessable_entity
    end
  end

  def update
    @rental = Rental.find(params[:id])
    if @rental.update(rental_params)
      redirect_to owner_rentals_path, notice: "Successfuly updated status"
    else
      render 'owner_rentals', status: :unprocessable_entity
    end
  end


  private

  def rental_params
    params.require(:rental).permit(:start_date, :status)
  end
end
