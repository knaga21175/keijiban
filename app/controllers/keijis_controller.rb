class KeijisController < ApplicationController
  before_action :store_logged_in, only: [:new, :edit, :create, :destroy]
  before_action :set_keiji, only: [:show, :edit, :update, :destroy]

  # GET /keijis
  # GET /keijis.json
  def index
    @keijis = Keiji.all
  end

  # GET /keijis/1
  # GET /keijis/1.json
  def show
    ### 閲覧数をカウントするために、あえてshowメソッドを通過させている
    _k = Keiji.find(params[:id])
    if( _k.pdffile_file_name != nil )
        _path = "/" + _k.pdffile.url(:original) 
        _k.viewcount += 1 
        _k.save
        
        redirect_to _path
    else
        redirect_to action: 'index', notice: '表示するデータがありません' 
    end
  end

  # GET /keijis/new
  def new
    @keiji = Keiji.new
    @category = Category.all
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
        @category = Category.all
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
      params.require(:keiji).permit(:start, :end, :category_id, :title, :viewcount, :pdffile, :pdffile_file_name, :pdffile_content_type, :pdffile_file_size, :pdffile_updated_at )
      
    end
end
