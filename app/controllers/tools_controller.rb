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

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    @tool.user = current_user

    if @tool.save
      redirect_to tools_path, notice: "Tool listed successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @booking = Booking.new(tool: @tool)
  end

  def my_tools
    @tools = current_user.tools
    @pending_bookings = Booking.joins(:tool)
                               .where(tools: { user_id: current_user.id }, status: "pending")
  end

  private

  def set_tool
    @tool = Tool.find(params[:id])
  end

  def tool_params
    params.require(:tool).permit(:name, :description, :condition, :price, :photo)
  end
end
