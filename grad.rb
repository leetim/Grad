require "mathn"

def sum(n)
	r = 0
	for i in (0...n)
		r += yield(i)
	end
	return r
end

class Array
	def rate
		sum(self.size){|i| self[i].abs}
	end
end

a = Array.new(7) do |i|
	Array.new(7){|j| 1 / (i + j + 1)}
end
f = Array.new(7) {|i| [sum(7){|j| a[i][j]}]}
r = Array.new(a.size){3}
p r
x = f.clone
e = 0.0001
count = 0
while r.rate > e 
	r = Matrix[*f] - (Matrix[*a] * Matrix[*x])
	t = Matrix[*a] * r
	t = t.t.to_a[0]
	r = r.t.to_a[0]
	alfa = sum(r.size){|i| r[i] ** 2} / sum(r.size){|i| r[i] * t[i]}.to_f
	x = Array.new(x.size){|i| [x[i][0] + alfa * r[i]]}
	count += 1
end
puts "#{count} итераций"
p x.map{|i| i[0]}