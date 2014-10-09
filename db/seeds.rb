Group.delete_all
User.delete_all
Comment.delete_all
Transaction.delete_all

padd = Group.create!(name: "Padd", blurb: "123 North Sesame Street")
hacker_house = Group.create!(name: "Hacker House", blurb: "555 West Kinzie")

colin = User.create!(email: "colin@mail.com", password: "colin", password_confirmation: "colin", first_name: "Colin", last_name: "Shevlin")
henry = User.create!(email: "henry@mail.com", password: "henry", password_confirmation: "henry", first_name: "Henry", last_name: "P")
andrea = User.create!(email: "andrea@mail.com", password: "andrea", password_confirmation: "andrea", first_name: "Andrea", last_name: "Simenstad")
jjp = User.create!(email: "jjp@mail.com", password: "jjp", password_confirmation: "jjp", first_name: "Just", last_name: "Johnpark")

padd.users << colin
padd.users << henry
hacker_house.users << andrea
hacker_house.users << jjp
hacker_house.users << colin

reminder = Comment.create!(commentable_id: 1, commentable_type: "Group", content: "We are attending the swinger party this weekend.", user_id: 1)
efficient = Comment.create!(commentable_id: 1, commentable_type: "Group", content: "I think the air conditioner is not efficient.", user_id: 2)
warning = Comment.create!(commentable_id: 2, commentable_type: "Group", content: "Get out of my way!", user_id: 4)

txn1 = Bill.create!(from_user_id: 1, to_user_id: 2, group_id: 1, amount: "100", confirmed: true)
txn2 = Payment.create!(from_user_id: 2, to_user_id: 1, group_id: 1, amount: "50", confirmed: false)
txn3 = Bill.create!(from_user_id: 3, to_user_id: 1, group_id: 2, amount: "200", confirmed: true)
txn4 = Bill.create!(from_user_id: 3, to_user_id: 4, group_id: 2, amount: "200", confirmed: true)
txn5 = Payment.create!(from_user_id: 4, to_user_id: 3, group_id: 2, amount: "200", confirmed: true)

txn_com_1 = Comment.create!(commentable_id: 1, commentable_type: "Transaction", content: "Henry, pay me for the toilet paper", user_id: 1)
txn_com_2 = Comment.create!(commentable_id: 2, commentable_type: "Transaction", content: "Colin, here is half for the TP", user_id: 2)
txn_com_3 = Comment.create!(commentable_id: 3, commentable_type: "Transaction", content: "JJP and Colin, pay up for the goods", user_id: 3)
txn_com_3 = Comment.create!(commentable_id: 4, commentable_type: "Transaction", content: "JJP and Colin, pay up for the goods", user_id: 3)
txn_com_3 = Comment.create!(commentable_id: 5, commentable_type: "Transaction", content: "Andrea, this is paid in full for the goods", user_id: 4)



