module Format
module HexArray
# ----------------
def to_s
  self.collect do |x|
    sprintf("%0.2X", x)
  end.join(" ")
end
# ----------------
end
end

