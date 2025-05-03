class RatingsController < ApplicationController
  before_action :authenticate_user!

  def create
    @tool = Tool.find(params[:tool_id])
    @rating = @tool.ratings.build(rating_params)
    @rating.user = current_user
    @rating.tool = @tool

    if @rating.save
      redirect_to tool_path(@tool), notice: "Thank you for your rating!"
    else
      redirect_to tool_path(@tool), alert: "There was a problem submitting your rating."
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:score)
  end
end
