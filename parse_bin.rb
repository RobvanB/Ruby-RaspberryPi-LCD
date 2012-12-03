class ParseBin
  # Return the binary value for a letter of the alphabet

  file = File.new("binAlphabet.txt", "r")

  @@map = Hash.new()
  #Store the map in a hash for easy retrieval
  while (line = file.gets)
      #puts  "#{line}"
      lineMap = line.split("|")
      #puts lineMap[0]
      #puts lineMap[2]
      @@map[lineMap[0]] = lineMap[2]
  end

  file.close

  def getBin(theChar)
    binArray = []
    binChar = @@map[theChar]
    binChar.split(//).each{ |intChar| binArray << intChar.to_i  }

    return binArray
  end

end
