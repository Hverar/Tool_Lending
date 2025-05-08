class ToolsController < ApplicationController
  before_action :set_tool, only: [:show]
  before_action :authenticate_user!
  before_action :authorize_owner!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @tools = Tool.all
    if params[:query].present?
      @tools = @tools.where("name ILIKE ? OR description ILIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end

    if params[:condition].present?
      @tools = @tools.where(condition: params[:condition])
    end

    if params[:min_price].present?
      @tools = @tools.where("tool_price >= ?", params[:min_price].to_f)
    end

    if params[:max_price].present?
      @tools = @tools.where("tool_price <= ?", params[:max_price].to_f)
    end
  end


  def new
    @tool = Tool.new
    authorize @tool
  end

  def edit
    @tool = current_user.tools.find(params[:id])
    authorize @tool
  end

  def update
    @tool = current_user.tools.find(params[:id])
    authorize @tool
    if @tool.update(tool_params)
      redirect_to tool_path(@tool), notice: "Tool updated successfully!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    @tool = Tool.new(tool_params)
    @tool.user = current_user
    authorize @tool

    if @tool.save
      redirect_to tools_path, notice: "Tool listed successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @tool = Tool.find(params[:id])
    @booking = Booking.new(tool: @tool)

    authorize @tool

    @show_exact_location = current_user&.bookings&.exists?(tool_id: @tool.id, status: "accepted")

    @markers = [{
      lat: @tool.latitude,
      lng: @tool.longitude
    }]
  end


  def my_tools
    @tools = current_user.tools
    @pending_bookings = Booking.joins(:tool).where(tools: { user_id: current_user.id }, status: "pending")
    @my_offers = current_user.bookings.includes(:tool)
  end

  def destroy
    set_tool
    if authorize @tool
      @tool.destroy
      redirect_to tools_path, notice: "Tool destroyed."
    end
    # if @tool.user == current_user
    #   @tool.destroy
    #   redirect_to tools_path, notice: "Tool was successfully deleted."
    # else
    #   redirect_to tool_path(tool), alert: "You are not authorized to delete this tool."
    # end
  end

  private

  def set_tool
    @tool = Tool.find(params[:id])
  end

  def tool_params
    params.require(:tool).permit(:name, :description, :condition, :tool_price, :photo)
  end

  def authorize_owner!
    # return if current_user&.owner?

    # redirect_to root_path, alert: "You are not authorized to perform this action."
  end
end
