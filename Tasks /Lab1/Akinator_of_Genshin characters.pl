:- dynamic asked/2.

% Основной предикат.
main :-
    retractall(asked(_,_)),
    findall(Question, question(_, Question), Questions),
    maplist(request, Questions),
    find_character(Character),
    nl,
    write('Скорее всего вы загадали '), write(Character), write('.'), nl.
main :-
    nl,
    write('Система не смогла угадать персонажа.'), nl.

% Предикат, который представляет список вопросов для акинатора и
% переменные для их идентификации.
question(hair, 'У вашего персонажа темные волосы?').
question(eyes, 'У вашего персонажа светлые глаза?').
question(age, 'Ваш персонаж взрослый?').
question(gender, 'Ваш персонаж женщина?').
question(arhont, 'Ваш персонаж Архонт?').
question(fatui, 'Ваш персонаж предвестник Фатуи?').

% Предикат, с именами персонажей и их характеристиками.
character(фурину, [hair-n, eyes-y, age-y, gender-y, arhont-y, fatui-n]).
character(райдэн_эи, [hair-n, eyes-n, age-y, gender-y, arhont-y, fatui-n]).
character(чжун_ли, [hair-y, eyes-y, age-y, gender-n, arhont-y, fatui-n]).
character(cандоре, [hair-n, eyes-y, age-y, gender-y, arhont-n, fatui-y]).
character(cару, [hair-y, eyes-y, age-y, gender-y, arhont-n, fatui-n]).
character(колумбину, [hair-y, eyes-n, age-y, gender-y, arhont-n, fatui-y]).
character(венти, [hair-y, eyes-n, age-y, gender-n, arhont-y, fatui-n]).
character(тарталью, [hair-n, eyes-y, age-y, gender-n, arhont-n, fatui-y]).
character(панталоне, [hair-y, eyes-n, age-y, gender-n, arhont-n, fatui-y]).
character(арлекину, [hair-n, eyes-n, age-y, gender-y, arhont-n, fatui-y]).
character(эмбер, [hair-y, eyes-n, age-y, gender-y, arhont-n, fatui-n]).
character(ёимию, [hair-n, eyes-y, age-y, gender-y, arhont-n, fatui-n]).
character(нахиду, [hair-n, eyes-y, age-n, gender-y, arhont-y, fatui-n]).
character(кэйю, [hair-y, eyes-y, age-y, gender-n, arhont-n, fatui-n]).
character(странника, [hair-y, eyes-n, age-y, gender-n, arhont-n, fatui-n]).
character(дилюка, [hair-n, eyes-y, age-y, gender-n, arhont-n, fatui-n]).
character(дотторе, [hair-n, eyes-n, age-y, gender-n, arhont-n, fatui-y]).
character(кокоми, [hair-n, eyes-n, age-y, gender-y, arhont-n, fatui-n]).
character(паймон, [hair-n, eyes-n, age-n, gender-y, arhont-n, fatui-n]).
character(син_цю, [hair-n, eyes-y, age-n, gender-n, arhont-n, fatui-n]).

% Предикат, который задает вопрос пользователю и записывает ответы.
% request(+Question)
request(Question) :-
    write(Question), write(' (y/n)? '),
    read(Reply),
    assert(asked(Question, Reply)).

% Предикаты для определения персонажа на основе ответов пользователя.
% find_character(+Character)
find_character(Character) :-
    character(Character, Traits),
    check_traits(Traits).

check_traits([]).
% check_traits([+Trait|-T])
check_traits([Trait|T]) :-
    question(Fact, Question),
    Trait = Fact-Answer,
    asked(Question, Answer),
    check_traits(T).
