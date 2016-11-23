files = []
input = File.open("input.txt", "r").each do |line|

  if line.include? ".jpg"
    files << line.split.last

    counts = Hash.new(0)
    files.each { |file| counts[file] += 1 }

    File.open('output.txt', 'w') do |f|
      counts.each do |x, y|
        f.puts "#{x} #{y}"
      end
    end
  end
end
