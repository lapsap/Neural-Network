% covariance matrix and mean vector
Sigma = [.01 0; 0 .01]; 
m = [0 1 1 0;    %mean vector of 4 class
     0 0 1 1];

% Generate 100 points and draw it to graph 1st
hold on
for i = 1 :4
    r(:,:,i) = mvnrnd(m(:,i)',Sigma,100); %random gaussian vectors
    plot( r(:,1,i) , r(:,2,i) , 'o' );  %plot the vector 1st
    weight(:,i) = zeros(1,3); %initial weight for each class
end

iteration = 0;
err = 1;
while err ~=0 && iteration < 20
    iteration = iteration + 1;
    err = 0;
    for class = 1 : 4
        for point = 1 : 100
            for dclass = 1 : 4
                D(dclass) = dot( [ r(point,1,class) , r(point,2,class) 1]' , weight(:,dclass) );
            end
            serr = 0;
            for dclass = 1 : 4
                if dclass ~= class && D(class) <= D(dclass)
                    weight(:,dclass) = weight(:,dclass) - [r(point,1,class) , r(point,2,class) 1]';
                    serr = 1; err = 1;
                end
            end
            if serr == 1
                weight(:,class) = weight(:,class) + [r(point,1,class) , r(point,2,class) 1]';
            end
        end
    end
end
weight = weight
% d1=d2; d1=d3; d1=d4; d2=d3; d2=d4; d3=d4
line(:,1) = weight(:,1) - weight(:,2);
line(:,2) = weight(:,1) - weight(:,3);
line(:,3) = weight(:,1) - weight(:,4);
line(:,4) = weight(:,2) - weight(:,3);
line(:,5) = weight(:,2) - weight(:,4);
line(:,6) = weight(:,3) - weight(:,4)

x =  -1 : .1 : 2;
for i = 1 : 6
    y = (-line(3,i) - line(1,i) * x ) / line(2,i);
    plot(x,y)
end
axis([-1 1.5 -1 1.5]);
