Module Nats.

Fixpoint eqb (n m : nat) : bool :=
    match n with
    | O =>  match m with
            | O => true
            | S _ => false
            end
    | S n' => match m with
            | O => false
            | S m' => eqb n' m'
            end
    end.

Notation "x =? y" := (eqb x y) (at level 70).

End Nats.

Module Lists.

Import Nats.

Notation "x :: xs" := (cons x xs)(at level 60, right associativity).
Notation "[ ]" := nil.
Notation "[ x ; .. ; y ]" := (cons x .. (cons y nil) .. ).
Notation "x ++ y" := (app x y) (at level 60, right associativity).

Fixpoint rev {X: Type} (l: list X) : list X :=
    match l with
    | nil => nil
    | x::xs => (rev xs) ++ [x]
    end.

Fixpoint nth_err {X: Type} (l: list X) (n: nat) : option X :=
    match l with
    | [] => None
    | x::xs => if n =? 0 then Some x else nth_err xs (pred n)
    end.

Fixpoint split {X Y: Type} (l: list (X * Y))
    : (list X) * (list Y) :=
    match l with
    | nil => (nil, nil)
    | cons (x, y) ls => match (split ls) with
                    | (p, q) => (cons x p, cons y q)
    end
    end.

End Lists.
