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
      respond_to do |format|
        if @document.save
          format.html { redirect_to online_presence_path, notice: 'Sucessfully Saved.' }
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
        @document = Document.find(params[:id])
        if @document.update(document_params)
          format.html { redirect_to online_presence_path, notice: 'Sucessfully Updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @document.errors, status: :unprocessable_entity }
        end
      end
    end

    def checkRecord
     if Document.where(:user_id => current_user.id).blank?
      create
  else
    update
  end
  end

    # DELETE /documents/1
    # DELETE /documents/1.json
    def destroy
      @document.destroy
      respond_to do |format|
        format.html { redirect_to online_presence_path }
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
        params.require(:document).permit(:file,:filename,:content_type,:file_contents, :user_id,:LinkedIn_URL,:Personal_URL,:StackOverflow_URL,:Blog_URL)
      end


  end