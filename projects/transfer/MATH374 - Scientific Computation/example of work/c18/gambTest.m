function prob = gambTest(maxIters)
  doubles = 0;
  money = 10000;
  initBet = 5;
  winProb = 0.4929;
  for k=1:maxIters
      a = gamblersRuin(money, initBet, winProb);
      if a >= 2*money
        doubles++;
      end
  end
  prob = (doubles/maxIters);
  return;
end
