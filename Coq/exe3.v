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

End Lists.

Import Lists.
Import Nats.

Theorem inj_ex1: forall (n m o: nat),
    [n;m] = [o;o] -> [n] = [m].
Proof.
    intros n m o H.
    injection H.
    intros H1 H2.
    rewrite H1.
    rewrite H2.
    reflexivity.
Qed.

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

Lemma eqs: forall n m: nat,
    eqb (S n) (S m) = eqb n m.
Proof.
      reflexivity.
Qed.

Theorem eqbt: forall n m, eqb n m = true -> n = m.
Proof.
    intro n. induction n as [|n' IHn'].
    - intros m eq. destruct m as [| m'].
      reflexivity.
      discriminate eq.
    - intros m eq. destruct m as [| m'].
      discriminate eq.
      rewrite -> eqs in eq.
      rewrite -> IHn' with m'.
      reflexivity.
      apply eq.
Qed.

Theorem nea: forall (n: nat) (X: Type) (l: list X),
    length l = n -> nth_err l n = None.
Proof.
    intros n X l.
    generalize dependent n.
    induction l as [|x xs IHxs].
    - intro n. destruct n as [| n'].
      + reflexivity.
      + intro H.
        discriminate H.
    - intro n. destruct n as [| n'].
      + intro H.
        discriminate H.
      + simpl. intro H.
        inversion H.
        apply IHxs.
        reflexivity.
Qed.

Fixpoint combine {X Y: Type} (lx: list X) (ly: list Y)
    : list (X * Y) :=
    match lx, ly with
    | [], _ => []
    | _, [] => []
    | x::tx, y::ty => (x, y) :: (combine tx ty)
    end.

Fixpoint split {X Y: Type} (l: list (X * Y))
    : (list X) * (list Y) :=
    match l with
    | [] => ([], [])
    | (x, y) :: ls => match (split ls) with
                    | (p, q) => (x :: p, y :: q)
    end
    end.

Lemma feq: forall {X Y: Type} (x y : X) (f: X -> Y),
    x = y -> f x = f y. Admitted.

Lemma rmcons: forall {X: Type} (lx ly: list X) (x: X),
    lx = ly -> x::lx = x::ly. Admitted.

Theorem comb_sp: forall X Y (l: list (X * Y)) l1 l2,
    split l = (l1, l2) ->
    combine l1 l2 = l.
Proof.
    intros X Y l.
    induction l as [| x xs IHx].
    - intros l1 l2.
      intro H.
      inversion H.
      reflexivity.
    - destruct x as [a b].
      simpl.
      destruct (split xs) as [lx ly].
      intros l1 l2 H.
      injection H as H1 H2.
      rewrite <- H1.
      rewrite <- H2.
      simpl.
      apply rmcons.
      apply IHx.
      reflexivity.
Qed.



