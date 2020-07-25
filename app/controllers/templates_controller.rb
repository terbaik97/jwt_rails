class TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :update, :destroy]

  # GET /templates
  def index
    @templates = Template.all

    render json: @templates
  end

  # GET /templates/1
  def show
    render json: @template
  end

  # POST /templates
  def create
    @template = Template.new(template_params)

    if @template.save
      render json: @template, status: :created, location: @template
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /templates/1
  def update
    if @template.update(template_params)
      render json: @template
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  # DELETE /templates/1
  def destroy
    @template.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Template.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def template_params
      params.require(:template).permit(:name)
    end
end
