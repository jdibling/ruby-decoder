class String
  def to_hex_a
    unpack("c"*size)
  end
end

