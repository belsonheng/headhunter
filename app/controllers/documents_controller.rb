class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @documents = Document.all
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
    send_data(@document.file_contents,
              type: @document.content_type,
              filename: @document.filename)
  end

  # GET /documents/new
  def new
    @document = Document.new
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = Document.new(document_params)
#NUM_BYTES_IN_MEGABYTE = 1048576
#check if user has document uploaded 
#if have delete
    respond_to do |format|
      if @document.save
        format.html { redirect_to jobseeker_home_path, notice: 'Document was successfully created.' }
        format.json { render action: 'show', status: :created, location: @document }
      else
        format.html { render action: 'new' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to jobseeker_home_path, notice: 'Document was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  def checkRecord
    
   if Document.where(:owner_email => current_user.email).blank?
    create
else
  respond_to do |format|
format.html { redirect_to jobseeker_home_path, notice: 'Document already exist!' }
end
end
end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to jobseeker_home_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = Document.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params.require(:document).permit(:file,:filename,:content_type,:file_contents, :owner_email)
    end


end