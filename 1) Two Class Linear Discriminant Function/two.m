% Points of class 1&2, with a '1' in the end
y = [1 0 ;
     1 0 ;
     1 1 ;];
 % initial weight
 a = zeros(3,size(y,2));

 err = 1;
 iteration = 0;
 while err ~= 0
         err = 0;
     iteration = iteration + 1;
     for i = 1 : size(y,2)
        for j = 1 : size(a,2)
           d(j) = dot( a(:,j)' , y(:,i)' );
        end
       flag = 0;
       for k = 1 : size(y,2)
          if (k ~= i) && (d(i) <= d(k))  
              flag = 1;
              err = 1;
          end
       end
       if flag == 1
           for k=1 : size(y,2)
               % error detected, alpha = 1
               if k==i
                   a(:,k) = a(:,k) + y(:,i);
               else 
                   a(:,k) = a(:,k) - y(:,i);
               end
           end
       end
     end
 end
 disp( ['Number of iteration : ' , num2str(iteration)] )

 hold on
 axis([-2 2 -1.5 1.5]);

% Draw the line that seperates both class
ans = a(:,1) - a(:,2) ;
input = [-3:.01:3] ;
ansy = (-ans(3) - ans(1) * input ) / ans(2);
plot(input, ansy);
             
% Generate some normal random points, and draw them             
x1 = randn(1,100);
y1 = randn(1,100);
t1 = ans(1) * x1 + ans(2) * y1 + ans(3);
for la = 1 : size(x1,2)
    if t1(la) > 0
        plot(x1(la),y1(la),'ro');
    else
        plot(x1(la),y1(la),'bx');
    end
end
             

 