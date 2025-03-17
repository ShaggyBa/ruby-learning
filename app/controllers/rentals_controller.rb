class RentalsController < ApplicationController
  before_action :set_rental, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :ensure_reader, only: [:new, :create]
  # GET /rentals or /rentals.json
  def index
    @rentals = Rental.all
  end

  # GET /rentals/1 or /rentals/1.json
  def show
  end

  # GET /rentals/new
  def new
    @rental = Rental.new
    @book = Book.find(params[:book_id])
    # Дополнительно можно передать текущего пользователя и дату аренды
  end

  # GET /rentals/1/edit
  def edit
  end

  # POST /rentals or /rentals.json
  def create
    @rental = Rental.new(rental_params)
    @rental.user = current_user
    @rental.rent_date = Date.today

    if @rental.save
      format.html { redirect_to @rental, notice: "Rental was successfully created." }
      format.json { render :show, status: :created, location: @rental }
      redirect_to rentals_path, notice: "Аренда оформлена"
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @rental.errors, status: :unprocessable_entity }
      render :new
    end
  end

  # PATCH/PUT /rentals/1 or /rentals/1.json
  def update
    respond_to do |format|
      if @rental.update(rental_params)
        format.html { redirect_to @rental, notice: "Rental was successfully updated." }
        format.json { render :show, status: :ok, location: @rental }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @rental.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rentals/1 or /rentals/1.json
  def destroy
    @rental.destroy!

    respond_to do |format|
      format.html { redirect_to rentals_path, status: :see_other, notice: "Rental was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_rental
    @rental = Rental.find(params.expect(:id))
  end

  # Only allow a list of trusted parameters through.
  def rental_params
    params.require(:rental).permit(:book_id, :collection_period, :librarian_id)
  end

  def ensure_reader
    redirect_to root_path, alert: "Доступ разрешён только читателям" unless current_user.reader?
  end
end
