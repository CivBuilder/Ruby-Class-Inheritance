# Description: This program illustrates classes/inheritance in ruby
# Date: 7/7/2022

# Note: I am SO sorry for the length of some lines, why is Ruby so finicky?!
# why does += not work ?!?!

class Bank_account

    attr_accessor :account_num, :account_holder, :account_users,
    :account_balance, :account_passcode, :recent_transactions

    def initialize(account_num, account_holder, account_users, account_balance, 
    account_passcode, recent_transactions)
        @account_num = account_num
        @account_holder = account_holder
        @account_users = account_users
        @account_balance = account_balance
        @account_passcode = account_passcode
        @recent_transactions = recent_transactions
    end

    def show_balance()
        puts "#{account_holder}'s current account balance is: $#{account_balance}"
    end

    def deposit() 
        old_balance = account_balance
        print "Please enter your account passcode: "
        input = gets.chomp.to_i

        if input == account_passcode
            print "Please enter an amount to deposit: "
            deposit_amount = gets.chomp.to_f
            recent_transactions.push("Deposit of $#{deposit_amount}")
            account_balance = old_balance + deposit_amount

        else
            puts "Incorrect passcode"
            account_balance = old_balance
        end
    end

    def withdraw()
        old_balance = account_balance
        print "Please enter your account passcode: "
        input = gets.chomp.to_i

        if input == account_passcode
            print "Please enter an amount to withdraw: "
            withdrawal_amount = gets.chomp.to_f

            if withdrawal_amount <= account_balance
                recent_transactions.push("Withdrawal of $#{withdrawal_amount}")
                account_balance = old_balance - withdrawal_amount

            else
                puts "Insufficient funds"
                account_balance = old_balance
            end

        else
            puts "Incorrect passcode"
            account_balance = old_balance
        end
    end

    def transfer(transfer_to)
        old_balance = account_balance
        print "Please enter your account passcode: "
        input = gets.chomp.to_i

        if input == account_passcode
            print "Please enter how much you would like to transfer to #{transfer_to.account_holder}: "
            transfer_amount = gets.chomp.to_f

            if transfer_amount <= account_balance
                other_balance = transfer_to.account_balance
                transfer_to.account_balance = transfer_amount + other_balance
                recent_transactions.push("Transfer of $#{transfer_amount} to #{transfer_to.account_holder}")
                account_balance = old_balance - transfer_amount

            else
                puts "Insufficient funds"
                account_balance = old_balance
            end

        else
            puts "Incorrect passcode"
            account_balance = old_balance
        end
    end

    def show_recent_transacts()
        puts "Recent transactions for #{account_holder}'s account:"
        puts recent_transactions
    end

end

class Savings_account < Bank_account

    attr_accessor :interest_rate, :num_withdrawals, :num_transfers

    def initialize(account_num, account_holder, account_users, account_balance, 
        account_passcode, recent_transactions, interest_rate)

        @interest_rate = interest_rate
        @num_withdrawals = 0
        @num_transfers = 0
        super(account_num, account_holder, account_users, account_balance, 
            account_passcode, recent_transactions)
    end

    def withdraw()
        old_balance = account_balance

        if num_withdrawals >= 3
            puts "You've exceeded the number of withdrawals allowed."
            account_balance = old_balance

        else
            print "Please enter your account passcode: "
            input = gets.chomp.to_i

            if input == account_passcode
                print "Please enter an amount to withdraw: "
                withdrawal_amount = gets.chomp.to_f
                # account balance was lost without this ?
                account_balance = old_balance

                if withdrawal_amount <= account_balance
                    recent_transactions.push("Withdrawal for $#{withdrawal_amount}")
                    account_balance = old_balance - withdrawal_amount

                else
                    puts "Insufficient funds"
                    account_balance = old_balance
                end

            else
                puts "Incorrect passcode"
                account_balance = old_balance
            end
        end
    end

    def transfer(transfer_to)
        old_balance = account_balance

        if num_transfers >= 3
            puts "You've exceeded the number of transfers allowed."
            account_balance = old_balance

        else
            print "Please enter your account passcode: "
            input = gets.chomp.to_i

            if input == account_passcode
                print "Please enter how much you would like to transfer to #{transfer_to.account_holder}: "
                transfer_amount = gets.chomp.to_f
                # account balance was lost again here without this ?
                account_balance = old_balance

                if transfer_amount <= account_balance
                    other_balance = transfer_to.account_balance
                    transfer_to.account_balance = transfer_amount + other_balance
                    recent_transactions.push("Transfer for $#{transfer_amount} to #{transfer_to.account_holder}")
                    account_balance = old_balance - transfer_amount

                else
                    puts "Insufficient funds"
                    account_balance = old_balance
                end

            else
                puts "Incorrect passcode"
                account_balance = old_balance
            end
        end
    end

    # please don't think I'm smooth brained enough to naturally try these next
    # two functions first. IDK if it's Ruby or repl.it but += and incrementing
    # in the above functions don't work. I'm sorry for what I'm about to do with these
    def inc_withdrawals()
        copy_num_withdrawals = num_withdrawals
        num_withdrawals = copy_num_withdrawals + 1
    end

    def inc_transfers()
        copy_num_transfers = num_transfers
        num_transfers = copy_num_transfers + 1
    end

end

# create objects and initialize
chris_account = Bank_account.new(1001, "Chris", ["Shelby", "Max", "Lady"], 1000, 1234, [])
shelby_account = Bank_account.new(1003, "Shelby", ["Chris", "Max", "Lady"], 5000, 8888, [])

chris_savings = Savings_account.new(1001, "Chris", ["Shelby", "Max", "Lady"], 1000, 1234, [], 5.2)
shelby_savings = Savings_account.new(1003, "Shelby", ["Chris", "Max", "Lady"], 5000, 8888, [], 3.7)

# method testing

# test bank account methods
chris_account.account_balance = chris_account.deposit()
chris_account.show_balance()


chris_account.account_balance = chris_account.withdraw()
chris_account.show_balance()

# I kept getting an error when trying to input who to transfer to
# plus in this case, the user wouldn't know my objects. For this reason,
# I hardcoded the object being transfered to. Sorry :-(
transfer_person = shelby_account

chris_account.account_balance = chris_account.transfer(transfer_person)
shelby_account.show_balance()
chris_account.show_balance()

chris_account.show_recent_transacts()

# test savings account methods
chris_savings.account_balance = chris_savings.withdraw()
chris_savings.num_withdrawals = chris_savings.inc_withdrawals()
chris_savings.show_balance()

chris_savings.account_balance = chris_savings.withdraw()
chris_savings.num_withdrawals = chris_savings.inc_withdrawals()
chris_savings.show_balance()

chris_savings.account_balance = chris_savings.withdraw()
chris_savings.num_withdrawals = chris_savings.inc_withdrawals()
chris_savings.show_balance()

# this should fail, fourth try
chris_savings.account_balance = chris_savings.withdraw()
chris_savings.num_withdrawals = chris_savings.inc_withdrawals()
chris_savings.show_balance()

transfer_person = shelby_account

chris_savings.account_balance = chris_savings.transfer(transfer_person)
chris_savings.num_transfers = chris_savings.inc_transfers()
chris_savings.show_balance()
shelby_savings.show_balance()

chris_savings.account_balance = chris_savings.transfer(transfer_person)
chris_savings.num_transfers = chris_savings.inc_transfers()
chris_savings.show_balance()
shelby_savings.show_balance()

chris_savings.account_balance = chris_savings.transfer(transfer_person)
chris_savings.num_transfers = chris_savings.inc_transfers()
chris_savings.show_balance()
shelby_savings.show_balance()

# this should fail, fourth try
chris_savings.account_balance = chris_savings.transfer(transfer_person)
chris_savings.num_transfers = chris_savings.inc_transfers()
chris_savings.show_balance()
shelby_savings.show_balance()

chris_savings.show_recent_transacts()