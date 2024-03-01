main :-
    retractall(asked(_,_)),
    fault(Problem),
    !,
    nl,
    write('Скорее всего вы загадали '), write(Problem), write(.), nl.
main :-
    nl,
    write('Система не смогла угадать персонажа.'), nl.

problem(hair) :-
    query('У вашего персонажа темные волосы?').

problem(eyes) :-
    query('У вашего персонажа светлые глаза?').

problem(age) :-
    query('Ваш персонаж взрослый?').

problem(gender) :-
    query('Ваш персонаж женщина?').

problem(arhont) :-
    query('Ваш персонаж Архонт?').

problem(fatui) :-
    query('Ваш персонаж предвестник Фатуи?').

fault(фурину) :-
    problem(arhont),
    problem(age),
    problem(gender),
    problem(eyes).

fault(райдэн_эи) :-
    problem(arhont),
    problem(age),
    problem(gender),
    problem(hair).

fault(чжун_ли) :-
    problem(arhont),
    problem(age),
    problem(eyes),
    problem(hair).

fault(сандоре) :-
    problem(fatui),
    problem(gender),
    problem(age),
    problem(eyes).

fault(сару) :-
    problem(gender),
    problem(age),
    problem(eyes),
    problem(hair).

fault(колумбину) :-
    problem(fatui),
    problem(gender),
    problem(age),
    problem(hair).

fault(венти) :-
    problem(arhont),
    problem(age),
    problem(hair).

fault(тарталью) :-
    problem(fatui),
    problem(age),
    problem(eyes).

fault(панталоне) :-
    problem(fatui),
    problem(age),
    problem(hair).

fault(арлекину) :-
    problem(fatui),
    problem(gender),
    problem(age).

fault(эмбер) :-
    problem(gender),
    problem(age),
    problem(hair).

fault(ёимию) :-
    problem(gender),
    problem(age),
    problem(eyes).

fault(нахиду) :-
    problem(arhont),
    problem(eyes),
    problem(gender).

fault(кэйю) :-
    problem(age),
    problem(eyes),
    problem(hair).

fault(странника) :-
    problem(age),
    problem(hair).

fault(дилюка) :-
    problem(age),
    problem(eyes).

fault(дотторе) :-
    problem(fatui),
    problem(age).

fault(кокоми) :-
    problem(gender),
    problem(age).

fault(паймон) :-
    problem(gender).

fault(син_цю) :-
    problem(eyes).

query(Prompt) :-
    (   asked(Prompt, Reply) -> true
    ;   nl, write(Prompt), write(' (y/n)? '),
        read(X),(X = y -> Reply = y ; Reply = n),
	assert(asked(Prompt, Reply))
    ),
    Reply = y.
