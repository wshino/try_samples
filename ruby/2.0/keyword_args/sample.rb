
def sample(name: "sample", num: 1)
	puts "#{name}, #{num}"
end

sample
sample(name: "test", num: 10)
sample(name: "test2")
sample(num: 5)

# 以下は不可
#sample("aaa", 3)

