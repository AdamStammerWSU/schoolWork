freq=[98.42, 176, 559, 991, 1934, 5085, 9900, 14140, 18150, 20490, 29500, 50350, 101400, 123000, 141000, 158000, 189000, 202000, 330000, 440000, 550000, 684000, 903000, 1150000, 1380000];
%frequencies used in hertz

inputVoltagePeak=[1, 1, 1, 1, 1, 1, 1, 1, 1.16, 1.2, 1.2, 1.2, 1.12, 1.12, 1.12, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2];
%Measured input peak voltages in volts

outputVoltagePeak=[9.4, 9.4, 9.4, 9.4, 9.4, 9.4, 9.4, 9.4, 9.64, 9.52, 9.52, 9.52, 9.04, 9.04, 8.88, 8.72, 8.48, 8.4, 6.88, 5.6, 4.72, 3.92, 2.88, 2.24, 1.76];
%Measured output peak voltages in volts

freqLog = log10(freq);
%make the frequency a log so that it smooths out better

Av=zeros(1,25);

for i=1:25
  Av(i)= outputVoltagePeak(i)/inputVoltagePeak(i);
endfor;
AvDB=20*log10(Av);
%calculate the gain in decibles
subplot(2, 2, 1);
scatter(freqLog, AvDB);
xlabel("Log(frequency) in Hertz");
ylabel("Voltage Gain in Decibles");
title("Logified Frequency vs. Gain");

subplot(2, 2, 3);
plot(freqLog, AvDB);
xlabel("Log(frequency) in Hertz");
ylabel("Voltage Gain in Decibles");
title("Logified Frequency vs. Gain");

subplot(2, 2, 2);
scatter(freq, Av);
xlabel("frequency in Hertz");
ylabel("Voltage Gain");
title("Frequency vs. Gain");

subplot(2, 2, 4);
plot(freq, Av);
xlabel("frequency in Hertz");
ylabel("Voltage Gain");
title("Frequency vs. Gain");
%plot the data in a scatter plot

filename = "bigGraph.png";
width = floor(1000);
height = floor((1080./1920.)*width);

size = strcat("-S", num2str(width), ",", num2str(height));
print(filename, "-dpng", size);
disp(strcat("Image Saved as ", " ", filename));
open(filename);