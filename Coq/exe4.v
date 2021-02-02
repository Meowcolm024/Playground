Require Import Setoid.

Lemma feq: forall {X Y: Type} (x y : X) (f: X -> Y),
    x = y -> f x = f y. Admitted.

Theorem bool3: forall (f: bool -> bool) (b: bool),
    f (f (f b)) = f b.
Proof.
    intros f b.
    destruct (f b) eqn: E.
    - destruct b.
      rewrite -> E.
      apply E.
      destruct (f true) eqn: Et.
      apply Et.
      apply E.
    - destruct b.
      destruct (f false) eqn: Et.
      apply E.
      apply Et.
      rewrite -> E.
      apply E.
Qed.

Theorem nion: forall (P: Prop),
  ~ P -> (forall (Q: Prop), P -> Q).
Proof.
  intros.
  apply H in H0.
  destruct H0.
Qed.

Theorem contrapositive: forall (P Q: Prop),
  (P -> Q) -> (~ Q -> ~ P).
Proof.
  intros.
  intro.
  apply H0 in H.
  destruct H.
  apply H1.
Qed.

Theorem dist_and: forall P Q R: Prop,
  (P \/ (Q /\ R)) <-> (P \/ Q) /\ (P \/ R).
Proof.
  intros P Q R.
  split.
  - intro H.
    split.
    + destruct H as [Hp | [Hq Hr]].
      left. apply Hp.
      right. apply Hq.
    + destruct H as [Hp | [Hq Hr]].
      left. apply Hp.
      right. apply Hr.
  - intro H.
    destruct H as [Hl Hr].
    destruct Hl as [Hp | Hq].
    + left. apply Hp.
    + destruct Hr.
      left. apply H.
      right. split. apply Hq. apply H.
Qed.

Theorem dist_exe: forall (X: Type) (P Q: X -> Prop),
  (exists x, P x \/ Q x) <-> (exists x, P x) \/ (exists x, Q x).
Proof.
  intros X P Q.
  split.
  - intros [x [Hl | Hr]].
    + left.
      exists x.
      apply Hl.
    + right.
      exists x.
      apply Hr.
  - intros [Hl | Hr].
    + destruct Hl.
      exists x.
      left. apply H.
    + destruct Hr.
      exists x.
      right. apply H.
Qed.

Notation "x :: xs" := (cons x xs)(at level 60, right associativity).
Notation "[ ]" := nil.
Notation "[ x ; .. ; y ]" := (cons x .. (cons y nil) .. ).
Notation "x ++ y" := (app x y) (at level 60, right associativity).

Fixpoint In {A: Type} (x: A) (l: list A): Prop :=
  match l with
  | [] => False
  | x'::l' => x' = x \/ In x l'
  end.

Fixpoint map {X Y: Type} (f: X -> Y) (l: list X)
    : list Y :=
    match l with
    | nil => nil
    | x::xs => (f x) :: map f xs
    end.

Lemma Inmap: 
  forall (A B: Type) (f: A -> B) (l: list A) (y: B),
  In y (map f l) <->
  exists x, f x = y /\ In x l.
Proof.
  intros.
  split.
  - intro H.
    induction l as [| l' ls IHl].
    + inversion H.
    + simpl.
      destruct H.
      {
        exists l'.
        rewrite H.
        auto.
      }
      {
        destruct (IHl H).
        exists x.
        split.
        apply H0.
        right. apply H0.
      } 
  - intro H.
    induction l as [| l' ls IHl].
    + destruct H.
      simpl in H.
      apply H.
    + destruct H.
      simpl in H.
      destruct H.
      destruct H0.
      * rewrite H0.
        simpl.
        left. apply H.
      * simpl.
        right.        
        apply IHl.
        exists x.
        split.
        rewrite H. reflexivity.
        apply H0.
Qed.

Lemma add_nil: forall (A: Type) (l: list A), l ++ [] = l. Admitted.

Lemma In_app: forall A l l' (a: A),
  In a (l ++ l') <-> In a l \/ In a l'.
Proof.
  intros A l l' a.
  split.
  - intro H.
    induction l as [| x xs IHx].
    + induction l' as [| y ys IHy].
      simpl in H.
      simpl. left. apply H.
      simpl in H. simpl. right.
      apply H.
    + induction l' as [| y ys IHy].
      simpl in H.
      simpl. left.
      destruct H.
      * left. apply H.
      * right. 
        assert (P: In a (xs ++ []) = In a xs).
        {
          rewrite add_nil.
          reflexivity.
        }
        rewrite P in H. apply H.
      * simpl in H.
        destruct H.
        simpl. left. left. apply H.
        apply IHx in H.
        destruct H.
        simpl. left. right. apply H.
        right. apply H.
  - intro H.
    induction l as [| x xs IHx].
    + simpl in H.
      destruct H.
      destruct H. simpl. apply H.
    + induction l' as [| y ys IHy].
      * simpl. simpl in H.
        destruct H.
        assert (P: In a xs = In a (xs ++ [])).
        {
          rewrite add_nil.
          reflexivity.
        }
        rewrite <- P.
        apply H.
        destruct H.
      * simpl. destruct H. simpl in H.
        destruct H. left. apply H.
        right. apply IHx. left. apply H.
        simpl in H. destruct H.
        right. apply IHx. right. simpl. left. apply H.
        right. apply IHx. right. simpl. right. apply H.
Qed.
