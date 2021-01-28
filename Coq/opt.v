Fixpoint repeat {X: Type} (x: X) (count: nat) : list X :=
    match count with
    | 0 => nil
    | S count' => cons x (repeat x count')
    end.

Inductive list' {X: Type} : Type :=
    | nil'
    | cons' (x: X) (l: list').

Check cons'.

Definition natnil := @nil' nat.

Check natnil.

Inductive prod (X Y: Type) : Type :=
    | pair (x: X) (y: Y).

Arguments pair {X} {Y} _ _.

Notation "( x , y )" := (x, y).
Notation "X * Y" := (prod X Y): type_scope.

