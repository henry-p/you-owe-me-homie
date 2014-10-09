class GroupsController < ApplicationController
  def new
    @group= Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save && params[:users]
      @group.users << current_user
      rejects = @group.add_members(params["users"].values)
      unless rejects.empty?
        flash[:error] = "The following emails are not registered members: #{rejects.join(", ")}"
      end
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
    p "GROUP ------------------------------"
    p @group
    if @group.update_attributes(group_params) && params[:users]
      rejects = @group.add_members(params["users"].values)
      unless rejects.empty?
        flash[:error] = "The following emails are not registered members: #{rejects.join(", ")}"
      end
      redirect_to group_path(@group)
    else
      render 'edit'
    end
  end

  private

  def group_params
    params.permit(:name, :blurb)
  end


end
