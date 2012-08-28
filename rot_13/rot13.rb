class String
  def to_r13
    self.chars.inject('') { |string, char| string + char.rot13 }
  end

  def shift i
    self.chars.inject('') { |string, char| string + char.cshift(i) }
  end

  protected

  def cshift i
   c = self.ord + i
   c.chr
  end

  def rot13
    i = self.ord
    case i
    when 65..77, 97..109
      i + 13
    when 78..90, 110..122
      i - 13
    else
      i
    end.chr
  end

end
