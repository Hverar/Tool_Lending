class ToolsController < ApplicationController
  before_action :set_tool, only: [:show]

  def new
    @tool = Tool.new
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

 def index
   @tools = Tool.all
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
