class OysterCard

  DEFAULT_BALANCE = 0.freeze
  MAXIMUM_BALANCE = 90.freeze
  MINIMUM_BALANCE = 1.freeze
  MAX_BALANCE_ERROR = "Card limit of #{MAXIMUM_BALANCE} reached".freeze

  attr_reader :balance, :in_journey

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    raise MAX_BALANCE_ERROR if amount + balance >= MAXIMUM_BALANCE

    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def in_journey?
    @in_journey
  end

  def touch_in
    fail "You do not have enough in your balance!" if @balance < MINIMUM_BALANCE # No need to throw a raise!
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

end
