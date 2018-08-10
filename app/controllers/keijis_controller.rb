class KeijisController < ApplicationController
  before_action :set_keiji, only: [:show, :edit, :update, :destroy]

  # GET /keijis
  # GET /keijis.json
  def index
    @keijis = Keiji.all
  end

  # GET /keijis/1
  # GET /keijis/1.json
  def show
  end

  # GET /keijis/new
  def new
    @keiji = Keiji.new
  end

  # GET /keijis/1/edit
  def edit
  end

  # POST /keijis
  # POST /keijis.json
  def create
    @keiji = Keiji.new(keiji_params)

    respond_to do |format|
      if @keiji.save
        format.html { redirect_to @keiji, notice: 'Keiji was successfully created.' }
        format.json { render :show, status: :created, location: @keiji }
      else
        format.html { render :new }
        format.json { render json: @keiji.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /keijis/1
  # PATCH/PUT /keijis/1.json
  def update
    respond_to do |format|
      if @keiji.update(keiji_params)
        format.html { redirect_to @keiji, notice: 'Keiji was successfully updated.' }
        format.json { render :show, status: :ok, location: @keiji }
      else
        format.html { render :edit }
        format.json { render json: @keiji.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /keijis/1
  # DELETE /keijis/1.json
  def destroy
    @keiji.destroy
    respond_to do |format|
      format.html { redirect_to keijis_url, notice: 'Keiji was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keiji
      @keiji = Keiji.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def keiji_params
      params.require(:keiji).permit(:start, :end, :category, :title, :viewcount)
    end
end
