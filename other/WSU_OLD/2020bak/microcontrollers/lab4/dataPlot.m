%freq=[98.42, 176, 559, 991, 1934, 5085, 9900, 14140, 18150, 20490, 29500, 50350, 101400, 123000, 141000, 158000, 189000, 202000, 330000, 440000, 550000, 684000, 903000, 1150000, 1380000];
%frequencies used in hertz
%r=[1000000 470000 100000 47000]
%ib=[.01; .03; .13; .3;]
%ic=[3.77; 7.98; 15.8; 15.17;]
%beta=[377; 266; 121.538; 50.5667;]
%vce=[11.27; 7.09; .214; .149;]

##freq=[1000 100 30 10 20 50 5092 10000 30630 50710 100000 200500 1000000 1520000 2033000];
##iptp=[108 110 112 92 112 112 112 114 116 114 114 118 120 120 120];
##optp=[116 116 88 50 76 105 116 118 124 122 124 124 120 118 110];
##av=ones(1, 15);
##
##av = optp ./ iptp;
##
##freq = freq(1:(length(freq) - 3));
##av = av(1:(length(av) - 3));
##iptp = iptp(1:(length(iptp) - 3));
##optp = optp(1:(length(optp) - 3));


%linear fit line calculation

%fitLineFull = @(x) 26.228*x + 81.008
%fx1 = [vce(1); vce(length(vce))]
%fy1 = [fitLineFull(fx1(1)); fitLineFull(fx1(2))]

%fitLineActive = @(x) 22.898*x + 113.07
%fx2 = fx1
%fy2 = [fitLineActive(fx2(1)); fitLineActive(fx2(2))]



%plot(vce, beta, "o", fx1, fy1, "-", fx2, fy2, "--")
%plot(freq, av, "o");

data = [21.36, 21.36, 21.85, 21.36, 21.36, 21.36, 21.85, 22.83, 23.80, 24.29, 25.27, 25.76, 25.76, 26.74, 27.22, 27.22, 27.22, 27.22, 27.71, 27.22, 26.74, 26.74, 26.25, 26.25, 25.76, 26.25, 25.27, 25.27, 25.27, 25.27, 24.78, 24.78, 24.29, 24.78, 24.29, 23.80, 23.80, 23.80, 23.80, 23.80, 23.31, 23.31, 23.80, 23.80, 23.31, 22.83, 22.83, 23.31, 22.83];
seconds = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48];

%l=legend("Measured", "Full Trendline", "Active Trendline")
%legend(l, "location", "southeast")
%text(1, 186, "y=22.898x + 113.07")
%text(3, 112, "y=26.228x + 81.008")
%xlabel("Frequency (Hz)")

%plot(cpu(1:upperLimit), transaction(1:upperLimit), "o");
plot(seconds, data, "-");
grid();

ylabel("Temperature (C)")
xlabel("Time (Seconds)")
title("TMP36 Touch Test")


%inputVoltagePeak=[1, 1, 1, 1, 1, 1, 1, 1, 1.16, 1.2, 1.2, 1.2, 1.12, 1.12, 1.12, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2, 1.2];
%Measured input peak voltages in volts

%outputVoltagePeak=[9.4, 9.4, 9.4, 9.4, 9.4, 9.4, 9.4, 9.4, 9.64, 9.52, 9.52, 9.52, 9.04, 9.04, 8.88, 8.72, 8.48, 8.4, 6.88, 5.6, 4.72, 3.92, 2.88, 2.24, 1.76];
%Measured output peak voltages in volts

%freqLog = log10(freq);
%make the frequency a log so that it smooths out better

%Av=zeros(1,25);

%for i=1:25
%  Av(i)= outputVoltagePeak(i)/inputVoltagePeak(i);
%endfor;
%AvDB=20*log10(Av);
%calculate the gain in decibles
%subplot(2, 2, 1);
%scatter(freqLog, AvDB);
%xlabel("Log(frequency) in Hertz");
%ylabel("Voltage Gain in Decibles");
%title("Logified Frequency vs. Gain");

%subplot(2, 2, 3);
%plot(freqLog, AvDB);
%xlabel("Log(frequency) in Hertz");
%ylabel("Voltage Gain in Decibles");
%title("Logified Frequency vs. Gain");

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
##
filename = "graph.png";
width = floor(1000);
height = floor((1080./1920.)*width);

size = strcat("-S", num2str(width), ",", num2str(height));
print(filename, "-dpng", size);
disp(strcat("Image Saved as ", " ", filename));
open(filename);