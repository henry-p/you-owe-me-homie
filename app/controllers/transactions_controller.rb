class TransactionsController < ApplicationController
  def new
    group = Group.find_by_id(params[:group_id])
    @group_members = group.users - [current_user]
  end
end
