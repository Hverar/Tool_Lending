class ToolsController < ApplicationController
  before_action :set_tool, only: [:show]

  def index
    @tool = Tool.all

    if params[:condition].present?
      @tool = @tool.where(condition: params[:condition])
    end

    if params[:min_price].present?
      @tools = @tool.where("tool_price >= ?", params[:min_price])
    end

    if params[:max_price].present?
      @tools = @tool.where("tool_price <= ?", params[:max_price])
    end
  end

  def create
    @tool = Tool.new(tool_params)

    @tool.user = current_user # or however you're setting the user
    if @tool.save
      redirect_to tools_path, notice: "Tool listed successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  private

  def set_tool
    @tool = Tool.find(params[:id])
  end

  def tool_params
    params.require(:tool).permit(:name, :description, :condition, :price, :image)
  end
end
