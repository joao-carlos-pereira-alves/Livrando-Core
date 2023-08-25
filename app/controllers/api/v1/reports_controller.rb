class ReportsController < ApplicationController
  before_action :set_report, only: %i[ show update destroy ]

  # GET /reports
  # GET /reports.json
  def index
    @reports = Report.all
    @reports = Report.paginate(page: params[:page], per_page: params[:per_page]) if params[:page].present? && params[:per_page].present?
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(report_params)

    if @report.save
      render :show, status: :created
    else
      render json: @report.errors
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    if @report.update(report_params)
      render :show, status: :ok
    else
      render json: @report.errors
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def report_params
      params.require(:report).permit(:user_id, :description)
    end
end
