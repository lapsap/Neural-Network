For this code, i have a Covariance Matrix named 'Sigma' and 3 mean vectors.
Each mean vector is a class.

1) generate 100 normal random vectors for each class.
2) preset weight for each class to [0,0,0]
3) start training ( adjusting weight )
    training with all generated vectors ( 300 points )
    weight ajustment formula : w' = w +/- x  , where x is the current vector [x1,y1,1]
4) After the training is done, get the 3 lines.
    D1 = D2; D1 = D3; D2 = D3
5) find the intersection point of three lines.
6) plot it with some predetermined if-else   (to get better graph) 
