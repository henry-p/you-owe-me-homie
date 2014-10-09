padd = Household.create!(name: "Padd", address: "123 North Sesame Street")
hacker_house = Household.create!(name: "Hacker House", address: "555 West Kinzie")

colin = User.create!(email: "colin@mail.com", password: "colin", password_confirmation: "colin", first_name: "Colin", last_name: "Shevlin")
henry = User.create!(email: "henry@mail.com", password: "henry", password_confirmation: "henry", first_name: "Henry", last_name: "P")
andrea = User.create!(email: "andrea@mail.com", password: "andrea", password_confirmation: "andrea", first_name: "Andrea", last_name: "Simenstad")
jjp = User.create!(email: "jjp@mail.com", password: "jjp", password_confirmation: "jjp", first_name: "Just", last_name: "Johnpark")

padd.users << colin
padd.users << henry
hacker_house.users << andrea
hacker_house.users << jjp
hacker_house.users << colin

reminder = Comment.create!(commentable_id: 1, commentable_type: "Household", content: "We are attending the swinger party this weekend.", user_id: 1)
efficient = Comment.create!(commentable_id: 1, commentable_type: "Household", content: "I think the air conditioner is not efficient.", user_id: 2)
warning = Comment.create!(commentable_id: 2, commentable_type: "Household", content: "Get out of my way!", user_id: 4)

txn1 = Transaction.create!(from_user_id: 1, to_user_id: 2, household_id: 1, amount: 100, confirmed: true, is_bill: true)
txn2 = Transaction.create!(from_user_id: 2, to_user_id: 1, household_id: 1, amount: 50, confirmed: false, is_bill: false)
txn3 = Transaction.create!(from_user_id: 3, to_user_id: 1, household_id: 2, amount: 200, confirmed: true, is_bill: true)
txn4 = Transaction.create!(from_user_id: 3, to_user_id: 4, household_id: 2, amount: 200, confirmed: true, is_bill: true)
txn5 = Transaction.create!(from_user_id: 4, to_user_id: 3, household_id: 2, amount: 200, confirmed: true, is_bill: false)

txn_com_1 = Comment.create!(commentable_id: 1, commentable_type: "Transaction", content: "Henry, pay me for the toilet paper", user_id: 1)
txn_com_2 = Comment.create!(commentable_id: 2, commentable_type: "Transaction", content: "Colin, here is half for the TP", user_id: 2)
txn_com_3 = Comment.create!(commentable_id: 3, commentable_type: "Transaction", content: "JJP and Colin, pay up for the goods", user_id: 3)
txn_com_3 = Comment.create!(commentable_id: 4, commentable_type: "Transaction", content: "JJP and Colin, pay up for the goods", user_id: 3)
txn_com_3 = Comment.create!(commentable_id: 5, commentable_type: "Transaction", content: "Andrea, this is paid in full for the goods", user_id: 4)



