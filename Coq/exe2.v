Fixpoint split {X Y: Type} (l: list (X * Y))
    : (list X) * (list Y) :=
    match l with
    | nil => (nil, nil)
    | cons (x, y) ls => match (split ls) with
                    | (p, q) => (cons x p, cons y q)
    end
    end.

Notation "x :: xs" := (cons x xs)(at level 60, right associativity).
Notation "[ ]" := nil.
Notation "[ x ; .. ; y ]" := (cons x .. (cons y nil) .. ).
Notation "x ++ y" := (app x y) (at level 60, right associativity).

Example test_split:
    split [(1, false); (2, false)] = ([1;2], [false; false]).
Proof.
    reflexivity.
Qed.

Compute (fun x => x + 10).

Definition thrice {X: Type} (f: X -> X) (n: X) : X :=
    f (f (f n)).

Compute (thrice (fun x => x * 2) 4).

Fixpoint rev {X: Type} (l: list X) : list X :=
    match l with
    | nil => nil
    | x::xs => (rev xs) ++ [x]
    end.

Fixpoint map {X Y: Type} (f: X -> Y) (l: list X)
    : list Y :=
    match l with
    | nil => nil
    | x::xs => (f x) :: map f xs
    end.

Lemma mapl:forall  {X Y: Type} (f: X -> Y) (l: list X) (x: X),
    map f (l ++ [x]) = map f l ++ [f x].
Proof.
    intros X Y f l x.
    induction l as [| y ys IHy].
    reflexivity.
    simpl.
    rewrite -> IHy.
    reflexivity.
Qed.

Theorem map_rev: forall (X Y: Type) (f: X -> Y) (l: list X),
    map f (rev l) = rev (map f l).
Proof.
    intros X Y f l.
    induction l as [| x xs IHx].
    reflexivity.
    simpl.
    rewrite -> mapl.
    rewrite -> IHx.
    reflexivity.
Qed.

Fixpoint fold {X Y: Type} (f: X -> Y -> Y) 
    (l: list X) (b: Y) : Y :=
    match l with
    | nil => b
    | x::xs => f x (fold f xs b)
    end.

Definition fold_map {X Y: Type} (f: X -> Y)
    (l: list X) : list Y := fold (fun x y => (f x) :: y) l nil.

(* Lemma fmhd: forall {X Y: Type} (f: X -> Y) (x: X) (xs: list X),
    fold_map f (x::xs) = (f x) :: fold_map f xs.
Proof.
    intros X Y f x xs.
    induction xs as [| y ys IHy].
    - reflexivity.
    - 
Qed. *)

Theorem fm_correct: forall {X Y: Type} (f: X -> Y) (l: list X),
    map f l = fold_map f l.
Proof.
    intros X Y f l.
    induction l as [| x xs IHx].
    - reflexivity.
    - simpl.
      rewrite -> IHx.
      unfold fold_map.
      reflexivity.
Qed.

Fixpoint evenb (n: nat) : bool :=
    match n with
    | O => true
    | S O => false
    | S (S n') => evenb n'
    end.

Definition oddb (n: nat) : bool := negb (evenb n).

Theorem sill2a:
    forall (n m : nat), (n ,n) = (m, m) ->
    (forall (q r: nat), (q, q) = (r, r) -> 
    [q] = [r]) -> [m] = [n].
Proof.
    intros n m eq1 eq2.
    apply eq2.
    symmetry.
    apply eq1.
Qed.

Theorem sillyex: 
    (forall n, evenb n = true -> oddb (S n) = true) ->
    oddb 3 = true -> evenb 4 = true.
Proof.
    intros eq1 eq2.
    apply eq2.
Qed.

Lemma rev2: forall (l: list nat), rev (rev l) = l. Admitted.

Theorem rev_exe1: forall (l l': list nat),
    l = rev l' -> l' = rev l.
Proof.
    intros l l' eq1.
    rewrite -> eq1.
    rewrite -> rev2.
    reflexivity.
Qed.

Definition minus2 (n: nat) : nat :=
    match n with
    | 0 => 0
    | S 0 => 0
    | S (S x) => x
    end.

Theorem trans: forall (X: Type) (n m o: X),
    n = m -> m = o -> n = o.
Proof.
    intros X n m o eq1 eq2.
    rewrite -> eq1.
    apply eq2.
Qed.

Example tqe: forall (n m o p: nat),
    m = (minus2 o) -> 
    (n + p) = m ->
    (n + p) = (minus2 o).
Proof.
    intros n m o p.
    intros eq1 eq2.
    apply trans with (m := (minus2 o)).
    - rewrite -> eq2.
      apply eq1.
    - reflexivity.
Qed.
