class TransactionsController < ApplicationController
	def show
		@group = Group.find_by_id(params[:group_id])
    @member = User.find_by_id(params[:member_id])

    @transactions_from_member = Transaction.where("from_user_id = #{@member.id} AND to_user_id = #{current_user.id}")
    @transactions_to_user = Transaction.where("from_user_id = #{current_user.id} AND to_user_id = #{@member.id}")

    @transactions = @transactions_from_member + @transactions_to_user

    # raise @transactions_to_user.inspect
	end
end



# raise @transactions_from_member.inspect

# [#<Bill id: 14, from_user_id: 2, to_user_id: 1, group_id: 1, amount: "200", confirmed: true, transaction_type: "Bill", created_at: "2014-10-10 01:11:22", updated_at: "2014-10-10 01:11:22">, #<Bill id: 13, from_user_id: 2, to_user_id: 1, group_id: 1, amount: "200", confirmed: true, transaction_type: "Bill", created_at: "2014-10-10 01:11:22", updated_at: "2014-10-10 01:11:22">, #<Bill id: 12, from_user_id: 2, to_user_id: 1, group_id: 1, amount: "200", confirmed: true, transaction_type: "Bill", created_at: "2014-10-10 01:11:22", updated_at: "2014-10-10 01:11:22">, #<Bill id: 11, from_user_id: 2, to_user_id: 1, group_id: 1, amount: "200", confirmed: true, transaction_type: "Bill", created_at: "2014-10-10 01:11:22", updated_at: "2014-10-10 01:11:22">, #<Payment id: 2, from_user_id: 2, to_user_id: 1, group_id: 1, amount: "50", confirmed: false, transaction_type: "Payment", created_at: "2014-10-10 01:11:22", updated_at: "2014-10-10 01:11:22">]>

# raise @transactions_to_user.inspect

#<ActiveRecord::Relation [#<Payment id: 9, from_user_id: 1, to_user_id: 2, group_id: 1, amount: "200", confirmed: true, transaction_type: "Payment", created_at: "2014-10-10 01:11:22", updated_at: "2014-10-10 01:11:22">, #<Payment id: 8, from_user_id: 1, to_user_id: 2, group_id: 1, amount: "200", confirmed: true, transaction_type: "Payment", created_at: "2014-10-10 01:11:22", updated_at: "2014-10-10 01:11:22">, #<Payment id: 7, from_user_id: 1, to_user_id: 2, group_id: 1, amount: "200", confirmed: true, transaction_type: "Payment", created_at: "2014-10-10 01:11:22", updated_at: "2014-10-10 01:11:22">, #<Payment id: 6, from_user_id: 1, to_user_id: 2, group_id: 1, amount: "200", confirmed: true, transaction_type: "Payment", created_at: "2014-10-10 01:11:22", updated_at: "2014-10-10 01:11:22">, #<Bill id: 1, from_user_id: 1, to_user_id: 2, group_id: 1, amount: "100", confirmed: true, transaction_type: "Bill", created_at: "2014-10-10 01:11:22", updated_at: "2014-10-10 01:11:22">]>

