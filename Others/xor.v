Definition Xor (x y: bool):= 
    match x, y with
    | true, true => false
    | false, false => false
    | _, _ => true
    end.

Theorem xor2: forall a b: bool,
    Xor (Xor a b) b = a.
Proof.
    intros.
    destruct a.
    - destruct b.
      reflexivity.
      reflexivity.
    - destruct b.
      reflexivity.
      reflexivity.
Qed.

Theorem xor_msg: forall p1 p2 k c1 c2: bool,
    c1 = Xor p1 k -> 
    c2 = Xor p2 k -> 
    Xor c1 c2 = Xor p1 p2.
Proof.
    intros.
    rewrite H. rewrite H0.
    destruct p1.
    - destruct p2.
      + destruct k.
        reflexivity. reflexivity.
      + destruct k.
        reflexivity. reflexivity.
        - destruct p2.
        + destruct k.
          reflexivity. reflexivity.
        + destruct k.
          reflexivity. reflexivity.
Qed.
