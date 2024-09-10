function output = linePainterMap(startC,endC,n)

if n == 1
    output = startC;
elseif n == 2
    output = [startC;endC];
else
    diff = (endC-startC)/(n-1);
    output = zeros([n,3]);
    for i = 1:n
        output(i,:)=startC+(i-1)*diff;
    end
end
end

