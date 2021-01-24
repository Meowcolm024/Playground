Inductive nat: Type :=
    | O
    | S (n: nat).

    Inductive bool: Type :=
    | true
    | false.

    Definition negb (b: bool) : bool :=
        match b with
        | true => false
        | false => true
        end.

Definition pred (n: nat) : nat :=
    match n with
    | O => O
    | S n' => n'
    end.

Check (S (S (S O))).

Fixpoint evenb (n: nat) : bool :=
    match n with
    | O => true
    | S O => false
    | S (S n') => evenb n'
    end.

Definition oodb (n: nat) : bool := negb (evenb n).

(* Module Nat1. *)

Fixpoint plus (n: nat) (m: nat) : nat :=
    match n with
    | O => m
    | S n' => S (plus n' m)
    end.

Compute (plus (S (S O)) (S O)).

Fixpoint mult (n m : nat) : nat :=
    match n with
    | O => O
    | S n' => plus m (mult n' m)
    end.

Fixpoint fact (n: nat) : nat :=
    match n with
    | O => S O
    | S n' => mult n (fact n')
    end.

Fixpoint minus (n m : nat) : nat :=
    match n, m with
    | O, _ => O
    | S _, O => n
    | S n', S m' => minus n' m'
    end.

Compute (fact (S (S (S O)))).

Notation "x + y" := (plus x y)
    (at level 50, left associativity).

Notation "x * y" := (plus x y)
    (at level 40, left associativity).

Fixpoint eqn (n m : nat) : bool :=
    match n with
    | O =>  match m with
            | O => true
            | S _ => false
            end
    | S n' => match m with
            | O => false
            | S m' => eqn n' m'
            end
    end.

Fixpoint leb (n m : nat) : bool :=
    match n with
    | O => true
    | S n' => match m with
              | O => false
              | S m' => leb n' m'
              end
    end.