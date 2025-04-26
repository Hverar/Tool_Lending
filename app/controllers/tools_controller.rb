class ToolsController < ApplicationController
  before_action :set_tools, only: [:show]

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

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)

    @tools.user = current_user # or however you're setting the user
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
    params.require(:tool).permit(:name, :description, :condition, :price, :photo)
  end
end
