function [x,y]=bezierDraw
figure(1); clf; axis([0 1 0 1]); grid on;  hold on;
t=0:.02:1;

x=[]; y=[];  n=0;
while(0 == 0)
    clf;   axis([0 1 0 1]); grid on;  hold on;
    m=floor(n/4);
    for k=1:m
        x1=x(4*k-3); y1=y(4*k-3);
        x2=x(4*k-2); y2=y(4*k-2);
        x3=x(4*k-1); y3=y(4*k-1);
        x4=x(4*k);   y4=y(4*k);
        
        plot([x1 x2],[y1 y2],'r:',x2,y2,'ms');
        plot([x3 x4],[y3 y4],'r:',x3,y3,'ms');
        plot(x1,y1,'ko',x4,y4,'ko');
        bx=3*(x2-x1); by=3*(y2-y1); % spline equations ...
        cx=3*(x3-x2)-bx;cy=3*(y3-y2)-by;
        dx=x4-x1-bx-cx;dy=y4-y1-by-cy;
        xp=x1+t.*(bx+t.*(cx+t*dx)); % Horner’s method
        yp=y1 +t.*(by+t.*(cy+t*dy));
        plot(xp,yp,'k-') % plot spline curve
        
        
    end
    
    
    
    skip=0;
    title('Pick starting point or Right Click to delete last group');
    [x1,y1,s1]=ginput(1);
    if (y1>1) || (x1>1)
        title('All Done!');
        break;
    end
    
    if (s1==3)  % delete
        if n>=4
            x=x(1:end-4); y=y(1:end-4);
            n=n-4;
            skip=1;
        else
            x=[];y=[];
            skip=1;
        end
    end
    
    if (n>0) && (x1<0)
        title('Click On Point to Move')
        while(0==0)
            [x1,y1]=ginput(1);
            chk4move= (abs(x1-x) + abs(y1-y)) < 0.04;
            id = find(chk4move);
            
            if (length(id)>=1)
                skip=1;
                plot(x1,y1,'b*','MarkerSize',16);
                [x1,y1]=ginput(1);
                x(id)=x1;
                y(id)=y1;
                pause(0.1);
                break;
            end
        end
    end
    
    
    if (skip==0)  && (s1==1)
        if n>=4  && ( (x1-x(end))^2 + (y1-y(end))^2 < 0.001)
            x1=x(end);
            y1=y(end);
        end
        plot(x1,y1,'bo','MarkerSize',12,'LineWidth',2);
        title('Pick End Point');
        [x4,y4]=ginput(1);
        plot(x4,y4,'bo','MarkerSize',12,'LineWidth',2);
        title('Pick First Control Point');
        [x2,y2] = ginput(1);
        plot(x2,y2,'rs','MarkerSize',12,'LineWidth',2);
        title('Pick Second Control Point');
        [x3,y3] = ginput(1);
        plot(x3,y3,'rs','MarkerSize',12,'LineWidth',2);
        xnew=[x1;x2;x3;x4]; ynew=[y1;y2;y3;y4];
        x=[x;xnew]; y=[y;ynew];
        n=n+4;
    end
    
    
    
end

if n>0
    m=n/4;
    x=reshape(x,4,m);
    y=reshape(x,4,m);
else
    x=[];
    y=[];
end
hold off;

end