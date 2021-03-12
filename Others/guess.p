male(tom).
male(jack).
male(ben).

female(alice).
female(lucy).
female(kay).

kitchen(jack).
kitchen(alice).
kitchen(lucy).

friend(tom, kay).
friend(jack, alice).
friend(ben, jack).
friend(kay, alice).
friend(jack, kay).

crime(X) :-
    male(X),
    \+ kitchen(X),
    \+ friend(X, kay).
