def wondrous n
  Enumerator.new do |enum|
    while n > 1
      n = n % 2 == 0 ? n / 2 : 3 * n + 1
      enum.yield n
    end
  end
end
