class PaymentsController < ApplicationController
  def new
    @group = Group.find_by_id(params[:group_id])
    @recipient = User.find_by_id(params[:recipient_id])
  end

  def create
    amount = params[:transaction_amount]
    group = Group.find_by_id(params[:group_id])
    recipient = User.find_by_id(params[:recipient_id])

    p = Payment.new(
      from_user: current_user,
      to_user: recipient,
      group_id: group.id,
      amount: amount
    )

    if !p.save
      flash[:error] = "There was an issue creating the payment. Please enter a valid amount."
    end

    redirect_to group_path(group)
  end
end


