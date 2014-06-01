text = File.read("ord.tex.orig")
text = text.gsub(/\\subsection(\[.*?\])?/, "\\BOGSTAV")
text = text.gsub(/\\BOGSTAV.*/, "\\0\n\n")
text = text.gsub(/\\\^\\j/, "\\^{\\j}")
text = text.gsub(/\\\^\\J/, "\\^{\\J}")
text = text.gsub(/\\~\{\} /, "\\T~")
text = text.gsub(/\\~\{\}/, "\\T{}")
text = text.gsub(/([0-9]+\.) */, "\\FED{\\1}~")
text = text.gsub(/\\foreignlanguage\{english\}/, "")
text = text.gsub(/\}\\textstylevesperantoopslagsord\{\\-\}\\textstylevesperantoopslagsord\{/, "\\-")
text = text.gsub(/\\ \\ /, " ")
text = text.gsub(/\\bigskip/, "")

# Fjern overflødige "selectlanguage"
text = text.gsub(/\}\n\n+\{\\selectlanguage\{danish\}/, "\n")
text = text.gsub(/\{\\selectlanguage\{danish\}/, "")
text = text.gsub(/\}\n\n+\\BOGSTAV/, "\n\n\\BOGSTAV")
text = text.gsub(/\\BOGSTAV\{.*$/, "\\0}")
text = text.gsub(/(Z\\"urich\))}/, "\\1")

File.open("ord.tex", "w") {|file| file.puts text}