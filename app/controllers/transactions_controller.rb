class TransactionsController < ApplicationController
  def edit
    transaction = Transaction.find_by_id(params[:id])
    transaction.update(confirmed: true)
    transaction.save
    redirect_to group_path(params[:group_id])
  end
end
