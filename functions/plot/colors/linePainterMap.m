function output = linePainterMap(startC,endC,n)

if n == 1
    output = endC;
    return
elseif n == 0
    output = startC;
    return
elseif n == 2
    output = [startC;endC];
    return
else
    diff = (endC-startC)/(n-1);
    output = zeros([n,3]);
    for i = 1:n
        output(i,:)=startC+(i-1)*diff;
    end
    return
end

end

