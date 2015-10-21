ans=0
for i=1:500, j=1:500, k=1:500
if i*i + j*j == k*k
ans = i*j*k
end
end
println(ans)
