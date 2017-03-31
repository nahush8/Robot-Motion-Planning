fid = fopen('input_maze.txt');

i = 1;
tline = fgetl(fid);
A0 = tline;

while ischar(tline)
    disp(tline)
    tline = fgetl(fid);
    eval(sprintf('A = tline', i));
    if (A == -1)
        break
    else
        b = str2num(A);
        for j = 1:numel(b)
            m(i, j) = b(j);
        end
    end
    i = i+1;
end


fclose(fid);