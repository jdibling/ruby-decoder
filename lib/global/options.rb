module Global
# -----------------
module Options
  def verb?()
    Decoder::App.verbose?
  end
  def sverb?()
    Decoder::App.super_verbose?
  end
  def payloads?
    Decoder::App.payloads?
  end

  def self.payloads?
    Decoder::App.paylods?
  end

  def show_hidden?
    Decoder::App.show_hidden?
  end
end
# -----------------
end
    

