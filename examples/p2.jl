Facx=1
Facy=2
evenno=2
limit =4000000
while Facx+Facy<limit
	sum = Facx+Facy
	Facx=Facy
	Facy=sum

		if sum%2==0
		evenno=evenno+sum
		end
end

println(evenno)
return 0
