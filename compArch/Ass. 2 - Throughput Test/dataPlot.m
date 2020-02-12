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

threadCount = [0 10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250 260 270 280 290 10 ];
transaction = [0.0 460.15142099405296 916.5475585981211 1371.7344939445875 1825.608558541601 2281.023221706978 2716.4019587512926 3187.3326626506187 3655.5480709065546 4050.8169120229404 4490.042729668206 4913.917861561106 5330.795953446703 5612.631910965554 6090.582352434226 6601.2108949147705 7158.567718812565 7775.906890067456 8203.078510314235 8623.373337049718 9017.817962078707 9505.25136347342 9856.70459691497 10425.402236544936 10607.055276893063 11232.78729525624 11114.84083278918 11178.853461735784 11570.121760312159 11421.124060459179 460.41552143436354 ];
cpu = [0.996053147507856 5.599313321912364 3.410151103979684 5.8716107035939835 7.565090908313979 7.212799158039649 4.569598250521887 8.191245806676475 7.157724454885937 14.914816970356421 8.905817812937553 19.457334901122007 16.231785640908267 29.490699827475108 29.481231588355207 24.98295045944791 31.013181632576163 11.378270226356014 17.789376726001144 21.777799067360732 32.908229368559724 36.923465989631175 44.872263348700066 39.89180653275395 54.98543205777783 47.12865937204919 85.65805640848346 100.0 100.0 100.0 7.398349507556315 ];

upperLimit = 30;

%linear fit line calculation

%fitLineFull = @(x) 26.228*x + 81.008
%fx1 = [vce(1); vce(length(vce))]
%fy1 = [fitLineFull(fx1(1)); fitLineFull(fx1(2))]

%fitLineActive = @(x) 22.898*x + 113.07
%fx2 = fx1
%fy2 = [fitLineActive(fx2(1)); fitLineActive(fx2(2))]



%plot(vce, beta, "o", fx1, fy1, "-", fx2, fy2, "--")
%plot(freq, av, "o");
subplot(2, 1, 1)
plot(threadCount(1:upperLimit), transaction(1:upperLimit), "o");
%axis([-25000 250000]);
grid();

%l=legend("Measured", "Full Trendline", "Active Trendline")
%legend(l, "location", "southeast")
%text(1, 186, "y=22.898x + 113.07")
%text(3, 112, "y=26.228x + 81.008")
%xlabel("Frequency (Hz)")
xlabel("Thread Count")
%ylabel("Av (Gain)")
ylabel("Transaction Count")
title("Transaction Count vs. Thread Count of HP Elitebook G2")


subplot(2, 1, 2)
%plot(cpu(1:upperLimit), transaction(1:upperLimit), "o");
plot(transaction(1:upperLimit), cpu(1:upperLimit), "-");
grid();

ylabel("CPU Utilization (%)")
xlabel("Transaction Count")
title("Transaction Count vs. CPU Utilization of HP Elitebook G2")


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
filename = "bigGraph.png";
width = floor(1000);
height = floor((1080./1920.)*width);

size = strcat("-S", num2str(width), ",", num2str(height));
print(filename, "-dpng", size);
disp(strcat("Image Saved as ", " ", filename));
open(filename);