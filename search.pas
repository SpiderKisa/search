const max = 20;

type vector = array [1..max] of word;

function BiSearch (const a: vector; const n: byte; const key: word):integer;
var left, right, i, find:byte;
    flag:boolean;
begin
  flag:=true;
  find:=0;
  left:=1;
  right:=n;
  for var j:=2 to n do
    if (a[j] < a[j-1])
      then flag:=false;
  if (flag = true)
     then while (left <= right) do begin
            i:=(left + right) div 2;
            if (key < a[i])
              then right:= i-1
              else if (key > a[i])
                     then left:=left+1
                     else begin
                          find:=i;
                          left:=right + 1;
                          end;
          end;
  if (flag = false)
    then result := -1
    else result:=find;
end;

function UniformBiSearch (const a: vector; const n: byte; const key: word):integer;
var d: vector;
    max, i, j, find: byte;
    flag, search: boolean;
begin
  search:=true; 
  flag:= true;
  for i:=2 to n do
    if (a[i] < a[i-1])
      then flag:=false;
  if (flag = true) then begin
  max:= trunc(ln(n)/ln(2)) + 2;
  for j:= 1 to max do
    d[j]:= trunc((n + exp((j - 1) * ln(2))) / (exp(j * ln(2))));
  i:=d[1];
  j:=2;
  while (search = true) and (find = 0) and ((i>0) and (i<=n)) do begin
    if (key < a[i])
      then begin 
        if (d[j] = 0)
          then search:=false
          else begin
            i:=i-d[j];
            j:=j+1;
          end;
    end 
    else if (key > a[i])
      then begin
        if (d[j] = 0)
          then search:=false
          else begin
            i:=i+d[j];
            j:=j+1;
          end;
      end
      else if (key = a[i])
         then find:=i;
    
  end;
  end;
  if (flag = false)
    then result:=-1
    else result:=find;
end;

var matrix: array [1..max] of vector;
    a: vector;
    size, k, l, i, j: byte;
    key:word;
    find: integer;
begin
  k:=0;
  i:=0;
  j:=0;
  writeln ('Enter size of matrix:');
  readln(size);
  for i:= 1 to size do begin
    writeln ('Enter ', i,' line:');
    for j:= 1 to size do
      read (matrix[i,j]);
  end;
  writeln('Enter key:');
  readln(key);
  l:=1;
 write ('Vector: ');
 for i:= 1 to size do begin//diagonal
     inc(k);
     a[k]:=matrix[i,i];
     if (k < size)
        then write(a[k],' ')
        else write(a[k],'. ');
   end;
   writeln;
    find:= BiSearch(a, size, key);
    if (find = -1)
      then writeln ('(Binary) Error: Sequence is not sorted.')
      else if (find = 0)
        then writeln ('(Binary) Key is not found.')
        else writeln ('(Binary): [', find,',',find,']');
     find:= UniformBiSearch(a, size, key);
    if (find = -1)
      then writeln ('(Uniform Binary) Error: Sequence is not sorted.')
      else if (find = 0)
        then writeln ('(Uniform Binary) Key is not found.')
        else writeln ('(Uniform Binary): [', find,',',find,']');
  while (l <= size - 1) do begin
    k:=0;
    write ('Vector: ');
    for i:= 1 to size-l do begin //above the main diagonal
      inc(k);
      a[k]:= matrix[i, i + l];
      if (k < size - l)
        then write(a[k],' ')
        else write(a[k],'. ');
    end;
     writeln;
    find:= BiSearch(a, size-l, key);
    if (find = -1)
      then writeln ('(Binary) Error: Sequence is not sorted.')
      else if (find = 0)
        then writeln ('(Binary) Key is not found.')
        else writeln ('(Binary): [', find,',',find+l,']');
     find:= UniformBiSearch(a, size-l, key);
    if (find = -1)
      then writeln ('(Uniform Binary) Error: Sequence is not sorted.')
      else if (find = 0)
        then writeln ('(Uniform Binary) Key is not found.')
        else writeln ('(Uniform Binary): [', find,',',find+l,']');
    k:=0;
    writeln;
    write ('Vector: ');
    for i:= l + 1 to size do begin //under the main diagonal
      inc(k);
      a[k]:= matrix[i, i - l];
      if (k < size - l)
        then write(a[k],' ')
        else write(a[k],'. ');
    end; 
    writeln;
    find:= BiSearch(a, size-l, key);
    if (find = -1)
      then writeln ('(Binary) Error: Sequence is not sorted.')
      else if (find = 0)
        then writeln ('(Binary) Key is not found.')
        else writeln ('(Binary): [', find+l,',',find,']');
     find:= UniformBiSearch(a, size-l, key);
    if (find = -1)
      then writeln ('(Uniform Binary) Error: Sequence is not sorted.')
      else if (find = 0)
        then writeln ('(Uniform Binary) Key is not found.')
        else writeln ('(Uniform Binary): [', find+l,',',find,']');
    inc(l);
    for i:=1 to k do
      a[i]:=0;
    writeln;
  end;
end.