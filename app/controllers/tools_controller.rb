class ToolsController < ApplicationController
  before_action :set_tool, only: [:show]

  def index
    @tools = Tool.all

    if params[:condition].present?
      @tools = @tools.where(condition: params[:condition])
    end

    if params[:min_price].present?
      @tools = @tools.where("tool_price >= ?", params[:min_price])
    end

    if params[:max_price].present?
      @tools = @tools.where("tool_price <= ?", params[:max_price])
    end
  end

  def show
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    @tool.user = current_user
    if @tool.save
      redirect_to tool_path(@tool), notice: "Tool listed successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_tool
    @tool = Tool.find(params[:id])
  end

  def tool_params
    params.require(:tool).permit(:name, :brand, :condition, :tool_price)
  end
end
