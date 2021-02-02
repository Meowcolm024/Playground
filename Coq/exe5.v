Axiom functional_extensionality:
    forall {X Y: Type} {f g: X -> Y},
    (forall (x: X), f x = g x) -> f = g.

Notation "x :: xs" := (cons x xs)(at level 60, right associativity).
Notation "[ ]" := nil.
Notation "[ x ; .. ; y ]" := (cons x .. (cons y nil) .. ).
Notation "x ++ y" := (app x y) (at level 60, right associativity).

Fixpoint rev {X: Type} (l: list X) : list X :=
    match l with
    | nil => nil
    | x::xs => (rev xs) ++ [x]
    end.

Fixpoint rev_append {X: Type} (l1 l2: list X): list X:=
    match l1 with
    | [] => l2
    | x::l1' => rev_append l1' (x::l2)
    end.

Definition tr_rev {X} (l: list X): list X := rev_append l [].

Lemma cons_app: forall (X: Type) (l1 l2: list X) (a: X),
    a :: l1 ++ l2 = (a::l1) ++ l2. Admitted.

Lemma rev_append_app': forall (X: Type) (l l1 l2 : list X),
    rev_append l (l1 ++ l2) = rev_append l l1 ++ l2.
Proof.
    intros.
    generalize dependent l1.
    generalize dependent l2.
    induction l.
    - reflexivity.
    - simpl.
      intros.
      rewrite -> cons_app.
      apply (@IHl l2 (a::l1)).
Qed.

Lemma tr_rev_correct: forall X, @tr_rev X = @rev X.
Proof.
    intros.
    apply functional_extensionality.
    intro x. induction x as [| t ts IHt].
    - reflexivity.
    - simpl. 
      rewrite <- IHt.
      simpl. unfold tr_rev. simpl.
      apply (@rev_append_app' X ts [] [t]).
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

Fixpoint eqb_list (l1 l2: list nat): bool :=
    match l1, l2 with
    | [], [] => true
    | x::l1', [] => false
    | [], x::l2' => false
    | x::l1', y::l2' => if eqb x y 
                        then eqb_list l1' l2'
                        else false
    end.

Lemma eq_cons: forall (x y: nat) (xs ys: list nat),
    x = y -> xs = ys <-> (x::xs) = (y::ys). Admitted.

Theorem eqb_list_true: 
    (forall a1 a2, eqb a1 a2 = true <-> a1 = a2) ->
    forall l1 l2, eqb_list l1 l2 = true <-> l1 = l2.
Proof.
    intros H.
    intro l1. induction l1 as [|x xs IHx].
    - intro l2. induction l2 as [|y ys IHy].
      + simpl. split.
        reflexivity. reflexivity.
      + simpl. split.
        intro. discriminate H0.
        intro. discriminate H0.
    - intro l2. induction l2 as [|y ys IHy].
      + simpl. split.
        intro. discriminate H0.
        intro. discriminate H0.
      + split.
        {
            intro. simpl in H0.
            destruct (eqb x y) eqn: P.
            apply IHx in H0.
            apply eq_cons.
            apply H. apply P.
            apply H0.
            discriminate H0.
        }
        {
            intro. simpl.
            destruct (eqb x y) eqn: P.
            apply IHx.
            inversion H0.
            reflexivity.
            inversion H0.
            apply H in H2.
            destruct P.
            apply H2.
        }
Qed.

Require Import Setoid.

Lemma neg_or: forall (P Q: Prop), ~ (P \/ Q) = (~P /\ ~Q). Admitted.
Lemma double_neg: forall P: Prop, ~~P = P.
Proof.
    intro. unfold not.
    intros. destruct H. reflexivity.
Qed.

Lemma fal: forall P: Prop, ~ (P /\ ~P ).
Proof.
    intro.
    unfold not.
    intros.
    destruct H. 
    apply H0 in H.
    apply H.
Qed.

Lemma unnot: forall P: Prop, ~ P = P -> False. Admitted.

Theorem exmd: forall (P: Prop),
    ~ ~ (P \/ ~ P).
Proof.
    intro P.
    assert (H: ~ (P \/ ~P) = (~P /\ ~~P)).
    {
        apply (@neg_or P (~P)).
    }
Abort.
   
(* Qed. *)
