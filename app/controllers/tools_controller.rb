class ToolsController < ApplicationController
  def show
    @tool = Tool.find(params[:id])
  end
  def index
    @tools = Tool.all
  end
end
