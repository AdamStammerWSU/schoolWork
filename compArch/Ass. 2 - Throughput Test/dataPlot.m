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

threadCount = [0 10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250 260 270 280 290 300 300 ];
transaction = [0.0 457.640018519176 930.8578158996893 1364.7967314923503 1824.0275004893467 2290.3875119379236 2768.347445545672 3206.034348448669 3647.8762152663085 4114.604757774099 4561.6289517942205 5044.421300944061 5493.707215830047 5892.2369107407485 6396.407283082164 6815.544191324512 7297.7790733324155 7750.626761595555 8167.532344578878 8635.554821609425 9023.430386556362 9139.45562963592 9777.271836646674 10090.991817940998 10774.682445242528 10978.216013806876 11578.391628922529 11461.022112722152 11887.490154455429 11855.054147408753 11069.157149215835 12098.832472673452 ];
cpu = [1.3440029549799726 12.123036713023303 1.9266547461536199 9.350229354610319 10.27939100572 12.076678570557231 7.738320521058293 10.542293921175178 10.875206751219897 6.7453560180437915 13.545161724880568 4.272971319979465 18.95165924528742 10.110328751683106 13.560664998431488 17.29071743586612 19.99404304482331 11.397096850909437 23.763531070169098 19.80438549641849 37.71270134910119 63.64077002776784 56.73032260776509 61.69280141639887 55.41074379728795 67.09061958595494 83.24012716672961 96.77138645273297 99.02069776495182 100.0 100.0 100.0 ];

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
ylabel("Transactions/Second")
title("Transactions/Second vs. Thread Count of HP Elitebook G2")


subplot(2, 1, 2)
%plot(cpu(1:upperLimit), transaction(1:upperLimit), "o");
plot(transaction(1:upperLimit), cpu(1:upperLimit), "-");
grid();

ylabel("CPU Utilization (%)")
xlabel("Transactions/Second")
title("Transactions/Second vs. CPU Utilization of HP Elitebook G2")


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
filename = "FixedMaxPluggedIn.png";
width = floor(1000);
height = floor((1080./1920.)*width);

size = strcat("-S", num2str(width), ",", num2str(height));
print(filename, "-dpng", size);
disp(strcat("Image Saved as ", " ", filename));
open(filename);