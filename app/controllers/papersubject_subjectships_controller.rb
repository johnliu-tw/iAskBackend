class PapersubjectSubjectshipsController < ApplicationController
  before_action :set_papersubject_subjectship, only: [:show, :edit, :update, :destroy]

  # GET /papersubject_subjectships
  # GET /papersubject_subjectships.json
  def index
    @papersubject_subjectships = PapersubjectSubjectship.all
  end

  # GET /papersubject_subjectships/1
  # GET /papersubject_subjectships/1.json
  def show
  end

  # GET /papersubject_subjectships/new
  def new
    @papersubject_subjectship = PapersubjectSubjectship.new
  end

  # GET /papersubject_subjectships/1/edit
  def edit
  end

  # POST /papersubject_subjectships
  # POST /papersubject_subjectships.json
  def create
    @papersubject_subjectship = PapersubjectSubjectship.new(papersubject_subjectship_params)

    respond_to do |format|
      if @papersubject_subjectship.save
        format.html { redirect_to @papersubject_subjectship, notice: '試卷科目以成功建立' }
        format.json { render :show, status: :created, location: @papersubject_subjectship }
      else
        format.html { render :new }
        format.json { render json: @papersubject_subjectship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /papersubject_subjectships/1
  # PATCH/PUT /papersubject_subjectships/1.json
  def update
    respond_to do |format|
      if @papersubject_subjectship.update(papersubject_subjectship_params)
        format.html { redirect_to @papersubject_subjectship, notice: '試卷科目以成功更新' }
        format.json { render :show, status: :ok, location: @papersubject_subjectship }
      else
        format.html { render :edit }
        format.json { render json: @papersubject_subjectship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /papersubject_subjectships/1
  # DELETE /papersubject_subjectships/1.json
  def destroy
    @papersubject_subjectship.destroy
    respond_to do |format|
      format.html { redirect_to papersubject_subjectships_url, notice: '試卷科目以成功刪除' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_papersubject_subjectship
      @papersubject_subjectship = PapersubjectSubjectship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def papersubject_subjectship_params
      params.fetch(:papersubject_subjectship, {})
    end
end
