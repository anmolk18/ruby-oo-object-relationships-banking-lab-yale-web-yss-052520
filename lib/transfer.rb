class Transfer

  attr_accessor :amount, :status
  attr_reader :sender, :receiver
  
  def initialize(sender, receiver, amount = 100)
    @sender = sender
    @receiver = receiver 
    @status = "pending"
    @amount = amount
  end 

  def valid?
    self.sender.valid? && self.receiver.valid?
  end 

  def execute_transaction
    if self.valid? && @status == "pending" && @sender.balance > @amount 
      @sender.deposit(-@amount)
      @receiver.deposit(@amount)
      @status = "complete" 
    else 
      @status = "rejected" 
      return "Transaction rejected. Please check your account balance."
    end 
  end
  
  def reverse_transfer 
    if @status == "complete"
      @sender.deposit(@amount)
      @receiver.deposit(-@amount)
      @status = "reversed"
    end 
  end
  
end
