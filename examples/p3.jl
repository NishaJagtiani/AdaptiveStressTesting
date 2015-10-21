num=600851475143
println("The largest prime factor of the number $num is")

div=2
ans=0

while(num!=0)

	if num%div!=0
	div =div+1

	else primFac=num
	num=num/div

		if num==1
		println(primFac)
		ans=1
		break
	    end
	end
end
return 0