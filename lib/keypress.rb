require 'io/console'

# Reads keypresses from the user including 2 and 3 escape character sequences.
def read_char
  STDIN.echo = false
  STDIN.raw!

  input = STDIN.getc.chr
  if input == "\e" then
    input << STDIN.read_nonblock(3) rescue nil
    input << STDIN.read_nonblock(2) rescue nil
  end
ensure
  STDIN.echo = true
  STDIN.cooked!

  return input
end

# oringal case statement from:
# http://www.alecjacobson.com/weblog/?p=75
def read_single_key
  c = read_char

  case c

  when "\r"
    return "RETURN"

  when "\e[A"
    return "w"
  when "\e[B"
    return "s"
  when "\e[C"
    return "d"
  when "\e[D"
    return "a"

  when "\u0003"
    puts "CONTROL-C"
    exit 0
  else
    return "SOMETHING ELSE: #{c.inspect}"
  end
end
