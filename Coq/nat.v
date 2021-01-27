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

Fixpoint leb (n m : nat) : bool :=
    match n with
    | O => true
    | S n' => match m with
              | O => false
              | S m' => leb n' m'
              end
    end.

Notation "x =? y" := (eqb x y) 
    (at level 70).
Notation "x <=? y" := (leb x y) 
    (at level 70).



Theorem plus_O_n: forall n : nat, O + n = n.
Proof.
    intros n. simpl. reflexivity.
Qed.

Theorem plus_1_n: forall n : nat, (S O) + n = S n.
Proof.
    intros n. simpl. reflexivity.
Qed.

Theorem plus_id: forall n m: nat, n = m -> n + n = m + m.
Proof.
    intros n m.
    intros H.
    rewrite -> H.
    reflexivity.
Qed.

Theorem plus_id_exe: forall n m o : nat, 
    n = m -> m = o -> n + m = m + o.
Proof.
    intros n m o.
    intros H.
    intros K.
    rewrite -> H.
    rewrite -> K.
    reflexivity.
Qed.

Theorem mult_0_plus: forall n m : nat,
    (O + n) * m = n * m.
Proof.
    intros n m.
    rewrite -> plus_O_n.
    reflexivity.
Qed.

Theorem mult_1_plus: forall n m : nat,
    m = S n ->
    m * ((S O) + n) = m * m.
Proof.
    intros n m.
    intros H.
    rewrite -> plus_1_n.
    rewrite -> H.
    reflexivity.
Qed.

Theorem plus_1_eq_0 : forall n : nat,
    (n + (S O)) =? O = false.
Proof.
    intros n.
    destruct n as [| n'] eqn: E.
    - reflexivity.
    - reflexivity.
Qed.

Theorem negneg: forall b: bool,
    negb (negb b) = b.
Proof.
    intros b.
    destruct b eqn: E.
    - reflexivity.
    - reflexivity.
Qed.

Definition andb (b1: bool) (b2: bool) : bool :=
    match b1 with
    | true => b2
    | false => false
    end.

Theorem andbcom: forall b c,
    andb b c = andb c b.
Proof.
    intros b c. destruct b eqn: Eb.
    - destruct c eqn: Ec.
        + reflexivity.
        + reflexivity.
    - destruct c eqn: Ec.
        + reflexivity.
        +reflexivity.
Qed.

(* Theorem andb_exch: forall b c d,
    andb (andb b c) d = andb b (andb c d).
Proof.
    intros [] [] [].
    - reflexivity.
    - reflexivity.
    - reflexivity.
    - reflexivity.
    - reflexivity.
    - reflexivity.
    - reflexivity.
    - reflexivity.
Qed. *)

Theorem andtrue: forall b c:bool, 
    (andb b c = true) -> (c = true).
Proof.
    intros b c.
    intro H.
    destruct c eqn: Ec.
        - reflexivity.
        - rewrite <- H.
            destruct b eqn: Eb.
            + reflexivity.
            + reflexivity.
Qed.

Theorem id_f_app2: 
    forall (f: bool -> bool),
    (forall (x: bool), f x = x) ->
        forall (b: bool), f (f b) = b.
Proof.
    intros f x.
    intro b.
    destruct b eqn: Eb.
        - rewrite <- x.
          rewrite <- x.
          reflexivity.
        - rewrite <- x.
          rewrite <- x.
          reflexivity.
Qed.

Definition orb (b1: bool) (b2: bool) : bool :=
    match b1 with
    | true => true
    | false => b2
    end.

Theorem andb_eq_orb: forall (b c: bool),
    (andb b c = orb b c) -> b = c.
Proof.
    destruct b.
    - destruct c.
      reflexivity.
      intro H.
      inversion H.
    - destruct c.
      intro H.
      inversion H.
      reflexivity.
Qed.
