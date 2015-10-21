sum_of_sequares = 0
sequare_of_sums = 0
for i = 1:100 
  sum_of_sequares += i * i
  sequare_of_sums += i
end
result = (sequare_of_sums * sequare_of_sums) - sum_of_sequares
println(result)