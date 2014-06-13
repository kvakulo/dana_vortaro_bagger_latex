text = File.read("ord.tex.orig")

lines = text.split("\n")

processedLines = []

processedLines.push(lines.shift)

lines.each do |line|
  if line.empty?
    processedLines.push("\n\n")
  else
    processedLines.push(line + " ")
  end
end

text = processedLines.join(" ")

text = text.gsub(/\\subsection(\[.*?\])?/, "\\BOGSTAV")


text = text.gsub(/  *\{\\selectlanguage\{danish\} *(.*(\{.*\})*.*)\} */, "\\1")

text = text.gsub(/\\\^\\j/, "\\^{\\j}")
text = text.gsub(/\\\^\\J/, "\\^{\\J}")
text = text.gsub(/\\~\{\} /, "\\T~")
text = text.gsub(/\\~\{\}/, "\\T{}")
text = text.gsub(/([^0-9])([0-9]\.) */, "\\1\\FED{\\2}~")
text = text.gsub(/\\foreignlanguage\{english\}/, "")
text = text.gsub(/\\ \\ /, " ")
text = text.gsub(/\\bigskip/, "")
text = text.gsub(/\\-/, "\\DEL ")
text = text.gsub(/\\textstylevesperantoopslagsord\{(.*?)\}\\textstylevesperantoopslagsord\{/, "\\textstylevesperantoopslagsord\{\\1")
text = text.gsub(/\\textstylevesperantoopslagsord\{(.*?)\}\\textstylevesperantoopslagsord\{/, "\\textstylevesperantoopslagsord\{\\1")
text = text.gsub(/\\textstylevesperantoopslagsord\{(.*?)\}\\textstylevesperantoopslagsord\{/, "\\textstylevesperantoopslagsord\{\\1")
text = text.gsub(/\\textstylevesperantoopslagsord\{(.*?)\}\\textstylevesperantoopslagsord\{/, "\\textstylevesperantoopslagsord\{\\1")

text = text.gsub(/\\textstylevesperantoopslagsord/, "\\OPSLAG")

text = text.gsub(/(\\BOGSTAV\{.*?\})(\\OPSLAG)/, "\\1\n\n\\2")

processedLines = []

text.each_line do |line|
  key = "\\OPSLAG{"
  index = line.index(key)
  if index
    start = index + key.length
    theEnd = start
    level = 0
    
    while true do
      if line[theEnd] == "{"
        level += 1
      elsif line[theEnd] == "}"
        if level == 0
          break
        else
          level -= 1
        end
      end
      theEnd += 1
    end
    length = theEnd - start
    
    opslag = line[start, length]
    udenDelinger = opslag.gsub(/\\DEL /, "")
    line = line.insert(theEnd + 1, "{" + udenDelinger + "}")
  end
  processedLines.push(line)
end

text = processedLines.join("\n")

text.each_line do |line|
  if line.scan("\\OPSLAG").count > 1
    print "* " + line + "\n"
  end
end

File.open("ord.tex", "w") {|file| file.puts text}