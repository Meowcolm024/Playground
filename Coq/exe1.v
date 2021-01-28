Fixpoint evenb (n: nat) : bool :=
    match n with
    | 0 => true
    | 1 => false
    | S (S n') => evenb n'
    end.

Definition negb (b: bool) : bool :=
    match b with
    | true => false
    | false => true
    end.

Fixpoint double (n: nat) :=
    match n with
    | 0 => 0
    | S n' => S (S (double n'))
    end.

Lemma dp: forall n:nat, double n = n + n. Admitted.
Lemma dn: forall b:bool, negb (negb b) = b.
Proof.
    intro b.
    destruct b.
    reflexivity.
    reflexivity.
Qed.
Theorem evenbs: forall n: nat,
    evenb (S n) = negb (evenb n).
Proof.
    intro n.
    induction n as [| n' IHn'].
    - simpl.
      reflexivity.
    - rewrite -> IHn'.
      simpl.
      rewrite -> dn.
      reflexivity.
Qed.

Lemma pc: forall n m: nat, n + m = m + n. Admitted.
Lemma pa: forall n m p:nat, n + (m + p) = (n + m) + p. Admitted.

Theorem plus_swap: forall n m p: nat,
    n + (m + p) = m + (n + p).
Proof.
    intros n m p.
    assert (H: n + (m + p) = (m + p) + n).
    {
        rewrite <- pa.
        rewrite <- pc.
        rewrite -> pa.
        reflexivity.
    }
    rewrite -> H.
    assert (G: n + p = p + n).
    {
        rewrite -> pc.
        reflexivity.
    }
    rewrite -> G.
    rewrite -> pa.
    reflexivity.
Qed.

Lemma mult0: forall n: nat,
    n * 0 = 0.
Proof.
    intro n.
    induction n as [|n' IHn'].
    reflexivity.
    simpl.
    rewrite -> IHn'.
    reflexivity.
Qed.

Lemma multp1: forall n m: nat,
    m + m * n = m * (S n).
Proof.
    intros n m.
    induction m as [|m' IHm'].
    - reflexivity.
    - simpl.
      rewrite -> plus_swap.
      rewrite -> IHm'.
      reflexivity.
Qed.

Theorem mult_comm: forall m n: nat,
    m * n = n * m.
Proof.
    intros n m.
    induction n as [|n' IHn'].
    - rewrite -> mult0.
      simpl.
      reflexivity.
    - simpl.
      rewrite -> IHn'.
      rewrite -> multp1.
      reflexivity.
Qed.

Lemma pns: forall n m:nat, S (n + m) = n + (S m). Admitted.
Lemma swap: forall n m:nat, n + m = m + n. Admitted.
Lemma inj: forall p q:nat, S p = S q -> p = q. Admitted.

Theorem plus_nn: forall n m,
    n + n = m + m -> n = m.
Proof.
    intro n. induction n as [| n'].
    - intros m eq.
      induction m as [| n'].
      reflexivity.
      discriminate eq.
    - intros m eq.
      destruct m.
      + discriminate eq.
      + injection eq.
        rewrite <- pns.
        intro H.
        assert (P: m + (S m) = S (m + m)).
        {
            symmetry.
            rewrite -> pns.
            reflexivity.
        }
        rewrite -> P in H.
        rewrite -> IHn' with m.
        reflexivity.
        apply inj in H.
    rewrite -> H.
    reflexivity.
Qed.

Lemma feq: forall {X Y: Type} (x y : X) (f: X -> Y),
    x = y -> f x = f y. Admitted.

Theorem dinj: forall n m,
    double n = double m ->
    n = m.
Proof.
    intros n m.
    generalize dependent n.
    induction m as [| m'].
    - simpl. intros n eq.
      destruct n as [| n'] eqn: E.
      reflexivity.
      discriminate eq.
    - intros n eq.
      destruct n as [| n'] eqn: E.
      discriminate eq.
      apply feq.
      apply IHm'.
      injection eq as goal.
      apply goal.
Qed.
