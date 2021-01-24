Theorem backward_huge : (forall A B C : Prop, A -> (A->B) -> (A->B->C) -> C).
Proof.
 intros A B C.
 intros proof_of_A A_implies_B A_imp_B_imp_C.
 refine (A_imp_B_imp_C _ _).
   exact proof_of_A.

   refine (A_implies_B _).
     exact proof_of_A.
Qed.
