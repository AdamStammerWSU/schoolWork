vi=[-1.76, -5.19, 3.73, 7.6, 11.37]
%the resistances used in ohms

vo=[-1.75, -5.17, 3.73, 7.58, 11.35]
%the respective current measured in milliAmps

h = scatter(vi, vo)
%plot the data in a scatter plot


m= (vi(5)-vi(1)) / (vo(5)-vo(1))
f = @(x) m*x

xlabel("Input Voltage (Vi)")
ylabel("Output Voltage (Vo)")
title("Amplifier Voltages")




%find a line of best fit
