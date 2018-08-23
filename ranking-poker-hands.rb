def letterToNum (arrNum, ace)
  e = 0
  d = 0
  arrNum.each_with_index do |value, index|
    case value
      when 'K'
        arrNum[index] = '13'
        e += 1
      when 'Q'
        arrNum[index] = '12'
        e += 1
      when 'J'
        arrNum[index] = '11'
        e += 1
      when 'A'
        arrNum[index] = '1'
        d = index
        ace = true
    end
    if e == 3
      arrNum[d] = '14'
    end
  end
  return e, ace
end

def winnerHand (arrHandOne)
  i = 0
  a = 0
  flush = false
  sum = 0
  ace = false

  arrNum = arrHandOne.map { |card|
    if card.length == 3
      card[0, 2]
    else
      card[0]
    end
  }

  arrSuit = arrHandOne.map { |card|
      if card.length == 3
        card[2]
      else
        card[1]
      end
  }

  while (arrSuit[i] == arrSuit[i+1]) do
    i = i+1
  end

  if i == 4
    flush = true
  end

  cont = letterToNum(arrNum, ace)
  arrNumSorted = arrNum.sort

  arrNumSorted.each {
    |element|
    sum += element.to_i
  }


  while ((arrNumSorted[a].to_i+1) == arrNumSorted[a+1].to_i) do
    a = a+1
  end

  b = Hash.new(0)
  pairs = 0
  tercia = false
  poker = false
  terciaCount = 0

  arrNumSorted.each do |v|
    b[v] += 1
  end

  b.each do |k, v|
    if v == 2
      pairs += 1
    end
    if v == 3
      terciaCount += 1
      tercia = true
    end
    if v == 4
      poker = true
    end
  end

  if terciaCount == 1 && pairs == 1
  #   "Full house"
    hand = 7
  elsif pairs == 1
  #   "1 pair"
    hand = 1
  elsif pairs == 2
  #   "2 pairs"
    hand = 3
  elsif tercia
  #   "tercia"
    hand = 4
  elsif poker
  #   "poker"
    hand = 8
  elsif a == 4
    if cont[0] == 3 && flush
    #   "Royal Flush"
      hand = 10
    else
      if flush
        hand = 9
      else
      #   "Straight"
        hand = 5
      end
    end
  elsif flush
    hand = 6
  else
  #   "Highest card"
    hand = 0
  end

  return hand, sum, cont[1]

end

arrHandOne = %w(KS QD AH JS 5S)
arrHandTwo = %w(2H 2C KH 5H 9C)
handOne = winnerHand (arrHandOne)
handTwo = winnerHand (arrHandTwo)

if handOne[0] > handTwo[0]
  puts arrHandOne.to_s
elsif handTwo[0] > handOne[0]
  puts arrHandTwo.to_s
elsif handOne[2] && !handTwo[2]
  puts arrHandOne.to_s
elsif !handOne[2] && handTwo[2]
  puts arrHandTwo.to_s
else
  totalSumOne = handOne[0] + handOne[1]
  totalSumTwo = handTwo[0] + handTwo[1]
  if totalSumOne > totalSumTwo
    puts arrHandOne.to_s
  else
    puts arrHandTwo.to_s
  end
end
