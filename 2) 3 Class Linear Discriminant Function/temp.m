% covariance matrix and mean vector
Sigma = [.01 0; 0 .01];
m1 = [0 0];
m2 = [1 0];
m3 = [1 1];

% Generate 100 points and draw it to graph 1st
hold on
r1 = mvnrnd(m1,Sigma,100);
r2 = mvnrnd(m2,Sigma,100);
r3 = mvnrnd(m3,Sigma,100);
plot( r1(:,1) , r1(:,2) , 'o' )
plot( r2(:,1) , r2(:,2) , 'o' )
plot( r3(:,1) , r3(:,2) , 'o' )

% Initial Weighting for 4 classes
weight1 = zeros(1,3);
weight2 = zeros(1,3);
weight3 = zeros(1,3);

% temp variable
tmp1x = r1(:,1); tmp1y = r1(:,2);
tmp2x = r2(:,1); tmp2y = r2(:,2);
tmp3x = r3(:,1); tmp3y = r3(:,2);

err = 1;
iteration = 0;
while err ~= 0
    err = 0;
    iteration = iteration + 1;

    % Class 1
    for la = 1 : size(tmp1x) % 10 % 100 gaussian point
        % class 1
        % get each Decision boundary
        D1 = dot( [tmp1x(la) tmp1y(la) 1] , weight1 );
        D2 = dot( [tmp1x(la) tmp1y(la) 1] , weight2 );
        D3 = dot( [tmp1x(la) tmp1y(la) 1] , weight3 );

        currentClassERR = 0; %if current class weight need to be ajusted
        % Check if other class weight need to be decrese 
        if D2 >= D1
            weight2 = weight2 - [tmp1x(la) tmp1y(la) 1];
            err = 1; % needs an extra iteration
            currentClassERR = 1;
        elseif D3 >= D1
            weight3 = weight3 - [tmp1x(la) tmp1y(la) 1];
            err = 1; % needs an extra iteration
            currentClassERR = 1;
        end
        % Check if current class weight need to be add
        if currentClassERR == 1
            weight1 = weight1 + [tmp1x(la) tmp1y(la) 1];
            currentClassERR = 0;
        end
        
        % class 2
        D1 = dot( [tmp2x(la) tmp2y(la) 1] , weight1 );
        D2 = dot( [tmp2x(la) tmp2y(la) 1] , weight2 );
        D3 = dot( [tmp2x(la) tmp2y(la) 1] , weight3 );

        % Check if other class weight need to be decrese 
        if D1 >= D2
            weight1 = weight1 - [tmp2x(la) tmp2y(la) 1];
            err = 1; % needs an extra iteration
            currentClassERR = 1;
        elseif D3 >= D2
            weight3 = weight3 - [tmp2x(la) tmp2y(la) 1];
            err = 1; % needs an extra iteration
            currentClassERR = 1;
        end
        % Check if current class weight need to be add
        if currentClassERR == 1
            weight2 = weight2 + [tmp2x(la) tmp2y(la) 1];
            currentClassERR = 0;
        end
        % class 3
        D1 = dot( [tmp3x(la) tmp3y(la) 1] , weight1 );
        D2 = dot( [tmp3x(la) tmp3y(la) 1] , weight2 );
        D3 = dot( [tmp3x(la) tmp3y(la) 1] , weight3 );

        % Check if other class weight need to be decrese 
        if D1 >= D3
            weight1 = weight1 - [tmp3x(la) tmp3y(la) 1];
            err = 1; % needs an extra iteration
            currentClassERR = 1;
        elseif D2 >= D3
            weight2 = weight2 - [tmp3x(la) tmp3y(la) 1];
            err = 1; % needs an extra iteration
            currentClassERR = 1;
        end
        % Check if current class weight need to be add
        if currentClassERR == 1
            weight3 = weight3 + [tmp3x(la) tmp3y(la) 1];
            currentClassERR = 0;
        end
      
        %loop end
    end

end

% draw
x = -1 : .1 : 2;
line1 = weight1 - weight2;
line2 = weight1 - weight3;
line3 = weight2 - weight3;

% get the intersection point of all lines
ka = [line1(1),line1(2); line2(1),line2(2); line3(1),line3(2)];
kk = [line1(3),line2(3),line3(3)]';
center = -ka\kk
plot(center(1),center(2),'*')

x1 = -1 : .01 : center(1) + .02 ;
x2 = center(1) : .1 : 2;
y1 = (-line1(3) - line1(1) * x1 ) / line1(2);
y2 = (-line2(3) - line2(1) * x1 ) / line2(2);
y3 = (-line3(3) - line3(1) * x2 ) / line3(2);

plot(x1 ,y1)
plot(x1 ,y2)
plot(x2 ,y3)


axis([-1 1.5 -1 1.5]);
