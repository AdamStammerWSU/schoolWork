function money=gamblersRuin(money,initBet,winProb)  
  
   % 
   %
   % 
   initMoney = money;
   bet = initBet; 
   while money>0 && money<(2*initMoney) 
      r = rand(); 
      if r < winProb 
        money = money+bet; 
        bet = initBet; 
      else 
        money = money-bet; 
        bet = min(2*bet,money);
      end  
   end
   return;
end