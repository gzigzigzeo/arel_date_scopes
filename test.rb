class A < Struct.new(:a)
end

class B < A
  def n
    5
  end
end

puts B.new.inspect
puts B.new.n