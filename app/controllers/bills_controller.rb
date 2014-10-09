class BillsController < ApplicationController
  def new
    group = Group.find_by_id(params[:group_id])
    @group_members = group.users - [current_user]
  end

  def create
    group = Group.find_by_id(params[:group_id])
    amount = params[:transaction_amount]

    if !params[:members]
      flash[:error] = "There was an issue creating the bill. Please select at least one member to bill."
    else
      params[:members].each do |key, email|

        user = User.find_by_email(email)
        t = Transaction.new(
          from_user: current_user,
          to_user: user,
          group_id: group.id,
          amount: amount,
          transaction_type: "Bill"
        )

        if !t.save
          flash[:error] = "There was an issue creating the bill. Please enter a valid amount."
        end
      end
    end

    redirect_to group_path(group)
  end
end
