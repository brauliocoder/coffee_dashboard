class CoffeeListsController < ApplicationController
  before_action :set_coffee_list, only: %i[ show edit update destroy ]

  # GET /coffee_lists or /coffee_lists.json
  def index
    @coffee_lists = CoffeeList.all
  end

  # GET /coffee_lists/1 or /coffee_lists/1.json
  def show
  end

  # GET /coffee_lists/new
  def new
    @coffee_list = CoffeeList.new
  end

  # GET /coffee_lists/1/edit
  def edit
  end

  # POST /coffee_lists or /coffee_lists.json
  def create
    @coffee_list = CoffeeList.new(coffee_list_params)

    respond_to do |format|
      if @coffee_list.save
        format.html { redirect_to coffee_list_url(@coffee_list), notice: "Coffee list was successfully created." }
        format.json { render :show, status: :created, location: @coffee_list }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @coffee_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /coffee_lists/1 or /coffee_lists/1.json
  def update
    respond_to do |format|
      if @coffee_list.update(coffee_list_params)
        format.html { redirect_to coffee_list_url(@coffee_list), notice: "Coffee list was successfully updated." }
        format.json { render :show, status: :ok, location: @coffee_list }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @coffee_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /coffee_lists/1 or /coffee_lists/1.json
  def destroy
    @coffee_list.destroy

    respond_to do |format|
      format.html { redirect_to coffee_lists_url, notice: "Coffee list was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_coffee_list
      @coffee_list = CoffeeList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def coffee_list_params
      params.require(:coffee_list).permit(:name, :origin, :price)
    end
end
