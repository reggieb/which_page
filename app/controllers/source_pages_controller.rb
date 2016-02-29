class SourcePagesController < ApplicationController
  before_action :set_source_page, only: [:show, :edit, :update, :destroy]

  # GET /source_pages
  # GET /source_pages.json
  def index
    @source_pages = SourcePage.all
  end

  # GET /source_pages/1
  # GET /source_pages/1.json
  def show
  end

  # GET /source_pages/new
  def new
    @source_page = SourcePage.new
  end

  # GET /source_pages/1/edit
  def edit
  end

  # POST /source_pages
  # POST /source_pages.json
  def create
    @source_page = SourcePage.new(source_page_params)

    respond_to do |format|
      if @source_page.save
        format.html { redirect_to @source_page, notice: 'Source page was successfully created.' }
        format.json { render :show, status: :created, location: @source_page }
      else
        format.html { render :new }
        format.json { render json: @source_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /source_pages/1
  # PATCH/PUT /source_pages/1.json
  def update
    respond_to do |format|
      if @source_page.update(source_page_params)
        format.html { redirect_to @source_page, notice: 'Source page was successfully updated.' }
        format.json { render :show, status: :ok, location: @source_page }
      else
        format.html { render :edit }
        format.json { render json: @source_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /source_pages/1
  # DELETE /source_pages/1.json
  def destroy
    @source_page.destroy
    respond_to do |format|
      format.html { redirect_to source_pages_url, notice: 'Source page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_source_page
      @source_page = SourcePage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def source_page_params
      params.require(:source_page).permit(:url)
    end
end
