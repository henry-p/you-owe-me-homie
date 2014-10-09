class GroupsController < ApplicationController
  def new
    @group= Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save && params[:users]
      @group.users << current_user
      rejects = @group.add_members(params["users"].values)
      unregistered_error(rejects) unless rejects.empty?
      redirect_to group_path(@group)
    else
      render 'new'
    end
  end

  def show
    @group = Group.find_by(id: params[:id])
  end

  def edit
    @group = Group.find_by(id: params[:id])
  end

  def update
    @group = Group.find_by(id: params[:id])
    if @group.update_attributes(group_params) && params[:users]
      rejects = @group.add_members(params["users"].values)
      unregistered_error(rejects) unless rejects.empty?
      redirect_to group_path(@group)
    else
      render 'edit'
    end
  end

  private

  def group_params
    params.require(:group).permit(:name, :blurb)
  end
  def unregistered_error(rejects)
    flash[:error] = "The following emails are not registered members: #{rejects.join(", ")}"
  end

end
