class TransactionsController < ApplicationController
	def show
		@group = Group.find_by_id(params[:group_id])
    @member = User.find_by_id(params[:member_id])

    txns = Transaction.where("from_user_id = #{current_user.id} AND to_user_id = #{@member.id} OR from_user_id = #{@member.id} AND to_user_id = #{current_user.id}")

    @transactions = txns.order('created_at DESC')
    



	end
end




