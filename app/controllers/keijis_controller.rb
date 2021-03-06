class KeijisController < ApplicationController
  before_action :store_logged_in, only: [:new, :edit, :create, :update, :destroy, :kanri]
  before_action :set_keiji, only: [:show, :edit, :update, :destroy]

  # GET /keijis
  # GET /keijis.json
  def index
    @keijis = Keiji.order("created_at DESC")
  end

  def kanri
    # 掲載期限切れの掲示を削除
    endofdate
    
    @keijis = Keiji.order("created_at DESC")
  end

  # GET /keijis/1
  # GET /keijis/1.json
  def show
    ### 閲覧数をカウントするために、あえてshowメソッドを通過させている
    _k = Keiji.find(params[:id])
    if( _k.pdffile_file_name != nil )
#        _path = ENV["WEB_ADDRESS_ROOT"] + "/" + _k.pdffile.url(:original) 
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
    @category = Category.all
  end

  # POST /keijis
  # POST /keijis.json
  def create
    @keiji = Keiji.new(keiji_params)

    respond_to do |format|
      if @keiji.save
          # mail配信
          _usr = User.all
          _usr.each do |r|
              if ( r.mail.presence )
                  MyMailer.kokuti( @keiji, r.mail ).deliver
              end
          end
        
        format.html { redirect_to kanri_keiji_path, notice: '登録しました' }
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
        format.html { redirect_to kanri_keiji_path, notice: '更新しました' }
        format.json { render :show, status: :ok, location: @keiji }
      else
        @category = Category.all
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
      format.html { redirect_to kanri_keiji_path, notice: '削除しました' }
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

    #掲載期限切れの掲示を削除する
    def endofdate
        _d = Date.today
        _k = Keiji.all
         _k.each do |x|
             if ( x.end < _d ) 
                x.destroy
             end
        end
    end
end
