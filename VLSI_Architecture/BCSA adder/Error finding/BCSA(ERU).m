clc;
close all;
clear all;
m=8;

prompt = 'Adder Size 8 or 16? ';
N = input(prompt);
prompt = 'Block Size 2 or 4 or 8 ';
Q=input(prompt);
cin=0;
sum_1=zeros(1,N+1);
cout_1=zeros(1,N);
sum=zeros(1,N+1);
cout=zeros(1,N);
p=zeros(1,N);
g=zeros(1,N);
err=0;
med=0;
mred=0;
count=0;

avgerr=0;
 for it=1:1000000
  in1=randi((2^N)-1,1);
  in2=randi((2^N)-1,1);
%  for it=1:1
%  in1=14057;
%  in2=27623;
%% Accurate adder implementation

for i=1:N
a=bitget(in1,i);
b=bitget(in2,i);
if(i==1)
cout(i)=or(and(a,b),or(and(b,cin),and(cin,a)));
sum(i)=xor(a,xor(b,cin));
else
cout(i)=or(and(a,b),or(and(b,cout(i-1)),and(cout(i-1),a)));
sum(i)=xor(a,xor(b,cout(i-1)));
end
end
sum(N+1)=cout(N); 

%%approximate adder
%%for first adder block 
for i=1:Q
a=bitget(in1,i);
b=bitget(in2,i);

if(i==1)
    cout_1(i)=or(and(a,b),or(and(b,0),and(0,a)));
    sum_1(i)=xor(a,xor(b,0));
    g(i)=or(a,b);
elseif(i==Q)
        
        cipred=and(a,b);
        cout_1(i)=or(and(a,b),or(and(b,cout_1(i-1)),and(cout_1(i-1),a)));
        temp1=cout_1(i);
        sum_1(i)=xor(a,xor(b,cout_1(i-1)));
elseif(i~=Q)
   cout_1(i)=or(and(a,b),or(and(b,cout_1(i-1)),and(cout_1(i-1),a)));
   sum_1(i)=xor(a,xor(b,cout_1(i-1)));
   p(i)=xor(a,b);
   g(i)=or(a,b);
   
        
   
end

end
sl_1=or(cipred,~or(bitget(in1,Q+1),bitget(in2,Q+1)));
if(sl_1==1)
    cout_1(Q)=cipred;
else
    cout_1(Q)= cout_1(Q);
end
%%%%2nd adder till second to last adder
counter=(N/Q)-2;
for j=1:counter
for i=Q*j+1:Q*j+Q
a=bitget(in1,i);
b=bitget(in2,i);
if(i==Q*j+1)
    cout_1(i)=or(and(a,b),or(and(b,cout_1(i-1)),and(cout_1(i-1),a)));
    %% Error Correction Unit
    e=~or(a,b);
    f=and(temp1,e);
    d=xor(a,xor(b,cout_1(i-1)));
    sum_1(i)=or(d,f);  
elseif(i==Q*j+Q)
        
        cipred=and(a,b);
        cout_1(i)=or(and(a,b),or(and(b,cout_1(i-1)),and(cout_1(i-1),a)));
        temp_1=cout_1(i);
        sum_1(i)=xor(a,xor(b,cout_1(i-1)));
elseif(i~=Q*j+Q)
   cout_1(i)=or(and(a,b),or(and(b,cout_1(i-1)),and(cout_1(i-1),a)));
   sum_1(i)=xor(a,xor(b,cout_1(i-1)));
   

end

end
sl_1=or(cipred,~or(bitget(in1,Q*j+Q+1),bitget(in2,Q*j+Q+1)));
if(sl_1==1)
    cout_1(Q*j+Q)=cipred;
else
    cout_1(Q*j+Q)= cout_1(Q*j+Q);
end
end
%%%%final adder block starts
for i=Q*counter+Q+1:N
a=bitget(in1,i);
b=bitget(in2,i);
  if(i==((Q*counter)+Q+1))
      
    cout_1(i)=or(and(a,b),or(and(b,cout_1(i-1)),and(cout_1(i-1),a)));
    
    e=~or(a,b);
    
    f=and(temp1,e);
    
    d=xor(a,xor(b,cout_1(i-1)));
    
    sum_1(i)=or(d,f);
    
  else
   cout_1(i)=or(and(a,b),or(and(b,cout_1(i-1)),and(cout_1(i-1),a)));
   sum_1(i)=xor(a,xor(b,cout_1(i-1)));
  end
end

sum_1(N+1)=cout_1(N);
if(bi2de(sum)~=bi2de(sum_1))
  
        err=err+1;
        med=med+abs(bi2de(sum)-bi2de(sum_1));
        red=(abs(bi2de(sum)-bi2de(sum_1)))/(bi2de(sum));
        mred=mred+red;
        avgerr=avgerr+(bi2de(sum_1)-bi2de(sum));
    end
    count=count+1;
    disp(count) % total number of inputs
end
med=med/count;

nmed=med/2^N;
mred=mred/count;
errorfound=err/count;
avgerr=avgerr/count;
errorfound
nmed
mred
avgerr


