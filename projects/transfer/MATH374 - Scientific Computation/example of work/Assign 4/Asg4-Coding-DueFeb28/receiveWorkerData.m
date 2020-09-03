function [data1,data2,data3]= receiveWorkerData()

fid=fopen('worker1Data.txt','r');
data1=fscanf(fid,'%c');
fclose(fid);
fid=fopen('worker2Data.txt','r');
data2=fscanf(fid,'%c');
fclose(fid);
fid=fopen('worker3Data.txt','r');
data3=fscanf(fid,'%c');
fclose(fid);
% 2 Preprocess Data
data1=str2vec(data1);
data2=str2vec(data2);
data3=str2vec(data3);
n1 = length(data1);
n2 = length(data2);
n3 = length(data3);
temp=floor( [n1/16 n2/24 n3/12] );
N=min(temp);
data1=data1(1:16*N);
data2=data2(1:24*N);
data3=data3(1:12*N);


    
    
    
    
    
    function w=str2vec(x)
        nx=length(x);
        w = zeros(nx,1);
        for k=1:nx
            w(k)=str2num(x(k));
        end
        
        
        
        
        
    end



end