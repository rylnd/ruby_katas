def rubyquiz
  ways = ['', '-', '+'].repeated_permutation(8).to_a

  ways.each do |w|
    # eq = (1..9).to_a.join('%s') % w
    eq = "1%s2%s3%s4%s5%s6%s7%s8%s9" % w
    puts eq if eval(eq) == 100
  end
  return
end

def rubyquiz2
  ways = ['', '-', '+'].repeated_permutation(8).to_a

  ways.reduce([]) do |arr, el|
    eq = (1..9).to_a.join('%s') % el
    eval(eq) == 100 ? arr << eq : arr
  end
end
