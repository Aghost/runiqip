#! /usr/bin/ruby

def grep_ip lines
  # Roughly matches ip-address [0-999.0-999.0-999.0-999.0-999]
  lines.map { |l| l.scan(/\b[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\b/) }.uniq
end

# Filters all ip's from file ARGV[0], outputs to file ARGV[1] or stdout.
case ARGV.length
when 1
  if File.exists?(ARGV[0])
    File.open(ARGV[0], "r") do |f|
      puts grep_ip f
    end
  else
    puts "No such file..."
  end
when 2
  if !File.exists?(ARGV[0]) || File.exists?(ARGV[1])
    abort "No such inputfile or outpufile already exists..."     
  else
    tempfile = grep_ip(File.read(ARGV[0]).split("\n"))

    File.write(ARGV[1],
               tempfile.reject(&:empty?).join("\n") + "\n")
  end
when 3
  puts "Read file, ignore all ip's from ignorefile, output to file"
else
  puts "Argument Error...\nUsage:\tCommand inputfile outputfile(optional) ignorelist(optional)\n\n"
end
