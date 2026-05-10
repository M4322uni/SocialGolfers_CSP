int: P;
int: G;
int: W;
array[1..P, 1..W] of var 1..G: X;

constraint assert(P > 0, "P must be greater than 0");
constraint assert(G > 0, "G must be greater than 0");
constraint assert(W > 0, "W must be greater than 0");
constraint assert(P mod G = 0, "P must be divisible by G");

constraint forall(w in 1..W, g in 1..G)
  (count([X[i, w] | i in 1..P], g) = P/G);
 
constraint forall(i in 1..P-1, j in i+1..P, 
  w1 in 1..W-1, w2 in w1+1..W)
  ((X[i, w1] != X[j, w1]) \/ (X[i, w2] != X[j, w2]));
 
solve satisfy;

output [ if p = 1 then "Week " ++ show(w) ++ ": " else "" endif ++ show(X[p, w]) 
  ++ if p = P then "\n" else " " endif | w in 1..W, p in 1..P]