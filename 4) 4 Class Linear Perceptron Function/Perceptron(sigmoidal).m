% covariance matrix and mean vector
Sigma = [.01 0; 0 .01]; 
m = [0 1 1 0;    %mean vector of 4 class
     0 0 1 1];

% Generate 100 points and draw it to graph 1st
%hold on
for i = 1 :4
    r(:,:,i) = mvnrnd(m(:,i)',Sigma,100); %random gaussian vectors
    weight(:,i) = zeros(1,3); %initial weight for each class
end

iteration = 0;
err = 1;
while err ~=0 && iteration < 50
    iteration = iteration + 1;
    err = 0;
    for class = 1 : 4
        for point = 1 : 100
            for dclass = 1 : 4
                D(dclass) = dot( [ r(point,1,class) , r(point,2,class) 1]' , weight(:,dclass) );
                activate = sigmf(2,[D(dclass) 1]);
                if dclass == class && activate <= 0.5
                    weight(:,class) = weight(:,class) + [ r(point,1,class) , r(point,2,class) 1]';
                    err = 1;
                elseif dclass ~= class && activate >= 0.5
                    weight(:,dclass) = weight(:,dclass) - [ r(point,1,class) , r(point,2,class) 1]';
                    err = 1;
                end
            end
        end
    end
    figure(iteration)
        hold on
    for i = 1 :4
        plot( r(:,1,i) , r(:,2,i) , 'o' );  %plot the vector 1st
    end
    line(:,1) = weight(:,1) - weight(:,2);
    line(:,2) = weight(:,1) - weight(:,3);
    line(:,3) = weight(:,1) - weight(:,4);
    line(:,4) = weight(:,2) - weight(:,3);
    line(:,5) = weight(:,2) - weight(:,4);
    line(:,6) = weight(:,3) - weight(:,4);

    x =  -1 : .1 : 2;
    for i = 1 : 6
        y = (-line(3,i) - line(1,i) * x ) / line(2,i);
        plot(x,y)
    end
    axis([-1 1.5 -1 1.5]);
    hold off
end
% d1=d2; d1=d3; d1=d4; d2=d3; d2=d4; d3=d4

