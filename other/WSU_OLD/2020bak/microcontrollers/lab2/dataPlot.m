freq=[98.42, 176, 559, 991, 1934, 5085, 9900, 14140, 18150, 20490, 29500, 50350, 101400, 123000, 141000, 158000, 189000, 202000, 330000, 440000, 550000, 684000, 903000, 1150000, 1380000];
%frequencies used in hertz

resistance=[200, 300, 400, 500, 600, 700, 800, 900, 1000, 1500, 2000, 2500, 3000, 4000, 5000, 6000, 7000];
%Decade box resistance

current=[10, 7.4, 5.7, 4.7, 4, 3.5, 3.1, 2.8, 2.5, 1.7, 1.3, 1.1, .9, .7, .6, .5, .4];
%Measured current in mA

linResistance = zeros(1,length(resistance));
%make the frequency a log so that it smooths out better

##Av=zeros(1,25);
##
for i=1:length(resistance)
  linResistance(i)= 1/resistance(i);
endfor;
##AvDB=20*log10(Av);
##%calculate the gain in decibles
##subplot(2, 2, 1);
##scatter(freqLog, AvDB);
##xlabel("Log(frequency) in Hertz");
##ylabel("Voltage Gain in Decibles");
##title("Logified Frequency vs. Gain");
##
##subplot(2, 2, 3);
##plot(freqLog, AvDB);
##xlabel("Log(frequency) in Hertz");
##ylabel("Voltage Gain in Decibles");
##title("Logified Frequency vs. Gain");
##
##subplot(2, 2, 2);
##scatter(freq, Av);
##xlabel("frequency in Hertz");
##ylabel("Voltage Gain");
##title("Frequency vs. Gain");
##
##subplot(2, 2, 4);
##plot(freq, Av);
##xlabel("frequency in Hertz");
##ylabel("Voltage Gain");
##title("Frequency vs. Gain");
##%plot the data in a scatter plot
trendline = @(x) 2043.3*x + 0.3559;
x = 0:.0001:.006;
scatter(linResistance, current);
hold on;
plot(x, trendline(x));
ylabel("Current (mA)");
xlabel("1/Resistance (\\Omega)");
title("Current vs. 1/Resistance");
legend("Data", "Trendline = 2043.3*x + 0.3559");

filename = "bigGraph2.png";
width = floor(1000);
height = floor((1080./1920.)*width);

size = strcat("-S", num2str(width), ",", num2str(height));
print(filename, "-dpng", size);
disp(strcat("Image Saved as ", " ", filename));
open(filename);