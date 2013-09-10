INPUT1 = "13+62*7+*"
INPUT2 = "11++"

def stack_machine_emulator(s)
  stack = []
  s.each_char do |e|
    puts "Stack -> #{stack} <- Stack"
    return -1 if (%w(+ *).include? e) && (stack.size < 2)
    case e
      when '+', '*'
        val1 = stack.pop
        val2 = stack.pop
        stack.push val1.send(e, val2)
      else
        stack.push e.to_i
    end
  end
  stack.last
end

puts stack_machine_emulator(INPUT1)