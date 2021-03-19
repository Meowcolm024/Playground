airport(can).
airport(hkg).
airport(nrt).
airport(lax).
airport(sfo).

direct(can, sfo).
direct(sfo, can).
direct(can, lax).
direct(lax, can).
direct(can, nrt).
direct(nrt, can).

direct(hkg, nrt).
direct(nrt, hkg).
direct(hkg, pek).
direct(pek, hkg).

one_stop(X, Y) :- 
    airport(Z),
    direct(X, Z), 
    direct(Z, Y).

reachable(X, Y) :- 
    (direct(X, Y); 
    one_stop(X, Y);
    airport(Z),
    one_stop(X, Z),
    reachable(Z, Y)).
