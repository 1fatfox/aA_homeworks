class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) {Array.new}
    place_stones
  end

  def place_stones
    @cups.each.with_index do |cup, i|
      next if i == 6 || i == 13
      4.times do
        cup << :stone
      end
    end

  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos < 0 || start_pos > 12
    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    stones = @cups[start_pos]
    @cups[start_pos] = []

    i = start_pos
    until stones.empty?
      i += 1
      i = 0 if i > 13
      if i == 6 && current_player_name == @name1
        @cups[6] << stones.shift
      elsif i == 13 && current_player_name == @name2
        @cups[13] << stones.shift
      else
        @cups[i] << stones.shift
      end
    end
    render
    next_turn(i)
  end

  def next_turn(ending_cup_idx)
     if ending_cup_idx == 6 || ending_cup_idx == 13
       :prompt
     elsif @cups[ending_cup_idx].count == 1
       :switch
     else
       ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    d@cups[0...7].all? { |cup| cup.empty? } || @cups[7..12].all? { |cup| cup.empty? }
  end

  def winner
    p1_score = @cups[6].count
    p2_score = @cups[13].count

    if p1_score == p2_score
      :draw
    else
      p1_score > p2_score ? @name1 : @name2
    end
  end
end
