Definition swap_pair (p: (nat * nat)) : (nat * nat) :=
    match p with
    | (x, y) => (y, x)
    end.

Theorem fss: forall p: (nat * nat),
    fst (swap_pair p) = snd p.
Proof.
    intro p.
    destruct p as [x y].
    reflexivity.
Qed.

Inductive natlist: Type :=
    | nil
    | cons (n: nat) (l: natlist).

Notation "x :: xs" := (cons x xs)(at level 60, right associativity).
Notation "[ ]" := nil.
Notation "[ x ; .. ; y ]" := (cons x .. (cons y nil) .. ).

Fixpoint repeat (n count: nat) : natlist :=
    match count with
    | 0 => nil
    | S count' => n :: (repeat n count')
    end.

Fixpoint length (l: natlist) : nat :=
    match l with
    | nil => 0
    | _ :: l' => S (length l')
    end.

Fixpoint app (l1 l2: natlist) : natlist :=
    match l1 with
    | nil => l2
    | h :: t => h :: (app t l2)
    end.

Notation "x ++ y" := (app x y) (at level 60, right associativity).

Definition hd (d: nat) (l: natlist) : nat :=
    match l with
    | nil => d
    | x :: _ => x
    end.

Definition tl (l: natlist) : natlist :=
    match l with
    | nil => nil
    | _ :: t => t
    end.

Fixpoint alternate (l1 l2: natlist) : natlist :=
    match l1, l2 with
    | xs, nil => xs
    | nil, xs => xs
    | (x::xs), (y::ys) => x :: y :: alternate xs ys
    end.

Fixpoint count (f: nat -> bool) (xs: natlist) (acc: nat) : nat :=
    match xs with
    | nil => acc
    | x::xs' => match (f x) with
               | true => count f xs' (S acc)
               | false => count f xs' acc
               end
    end.
 
Definition is1 (n: nat): bool := 
    match n with
    | S 0 => true
    | _ => false
    end.

Compute (count is1 [1;2;3;4;1;1] 0).

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

Fixpoint rm1 (n: nat) (l: natlist) : natlist :=
    match l with
    | nil => nil
    | x::xs => match (eqb x n) with
               | true => xs
               | false => x :: (rm1 n xs)
               end
    end.

Fixpoint rma (n: nat) (l: natlist) : natlist :=
    match l with
    | nil => nil
    | x::xs => match (eqb x n) with
               | true => rma n xs
               | false => x :: (rma n xs)
               end
    end.

Compute (rm1 5 [2;1;5;4;1]).
Compute (rma 5 [2;1;5;4;5;2]).

Theorem nil_app: forall l: natlist,
    [] ++ l = l.
Proof.
    reflexivity.
Qed.

Theorem app_nil_r: forall l: natlist,
    l ++ [] = l.
Proof.
    intro l.
    induction l as [| x xs IHx].
    reflexivity.
    simpl.
    rewrite -> IHx.
    reflexivity.
Qed.

Fixpoint rev (l: natlist) : natlist :=
    match l with
    | nil => nil
    | x::xs => (rev xs) ++ [x]
    end.

Lemma app_as: forall l1 l2 l3: natlist,
    (l1 ++ l2) ++ l3 = l1 ++ (l2 ++ l3).
Proof.
    intros l1 l2 l3.
    induction l1 as [| x xs IHx].
    - reflexivity.
    - simpl.
      rewrite -> IHx.
      reflexivity.
Qed.

Theorem rev_app_distr: forall l1 l2: natlist,
    rev (l1 ++ l2) = rev l2 ++ rev l1.
Proof.
    intros l1 l2.
    induction l1 as [|x xs IHx].
    - rewrite -> app_nil_r.
      reflexivity.
    - simpl.
      rewrite -> IHx.
      rewrite -> app_as.
      reflexivity.
Qed.

Theorem rev_inv:forall l: natlist,
    rev (rev l) = l.
Proof.
    intro l.
    induction l as [| x xs IHx].
    - reflexivity.
    - simpl.
      rewrite -> rev_app_distr.
      rewrite -> IHx.
      reflexivity.
Qed.

