// RUN: %boogie -noinfer -typeEncoding:m -useArrayTheory "%s" > "%t"
// RUN: %diff "%s.expect" "%t"
var {:layer 0,1} x:int;

procedure {:yields} {:layer 1} p() 
requires {:layer 1} x >= 5; 
ensures {:layer 1} x >= 8; 
{ 
    yield;
    assert {:layer 1} x >= 5; 
    call Incr(1); 
    yield;
    assert {:layer 1} x >= 6; 
    call Incr(1); 
    yield;
    assert {:layer 1} x >= 7;
    call Incr(1); 
    yield;
    assert {:layer 1} x >= 8; 
}

procedure {:yields} {:layer 1} q() 
{ 
    yield;
    call Incr(3); 
    yield;
}

procedure {:yields} {:layer 0,1} Incr(val: int);
ensures {:atomic}
|{A:
  x := x + val; return true;
}|;
