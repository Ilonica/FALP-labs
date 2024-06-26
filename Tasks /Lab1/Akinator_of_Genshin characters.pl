:- dynamic asked/2.

% Основной предикат
main:-
    retractall(asked(_,_)),
    findall(Char, character(Char, _), Characters),
    identify(Characters, Res),
    nl,
    write('Скорее всего вы загадали '), write(Res), write('.'), nl.
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

% Рекурсивный предикат, который идентифицирует персонажа, задавая
% последовательно вопросы о его характеристиках и запрашивая ответы.
% identify([+Character], +Character)
identify([Character], Character):- !.
% Предикат, который проверяет есть ли еще не заданные вопросы.
identify(_, _):-
    not(unanswered_questions), !.
identify(Characters, Result):-
    select_question(Characters, Question),
    request(Question, Reply),
    update_characters(Characters, Question, Reply, RefreshdCharacters),
    identify(RefreshdCharacters, Result).

% Предикат, который выбирает следующий вопрос для задания пользователю.
select_question(Characters, Question):-
    question(Fact, Q),
    not(asked(Fact, _)),
    relevant(Fact, Characters),
    Question = question(Fact, Q),
    !.

% Предикат, который задает вопрос пользователю и записывает ответы.
% request(question(+Fact, +Text), +Reply)
request(question(Fact, Text), Reply) :-
    (asked(Fact, Reply) -> true;
     nl, write(Text), write(' (y/n)? '),
     read(Reply),
     assert(asked(Fact, Reply))
    ).

% Проверка есть ли несколько уникальных значений для данного факта среди
% характеристик персонажей из списка.
% relevant(+Fact, +Characters)
relevant(Fact, Characters) :-
    findall(Answer, (member(Char, Characters), character(Char, Traits), member(Fact-Answer, Traits)), Vals),
    list_to_set(Vals, UniqueVals),
    length(UniqueVals, Length),
    Length > 1.

% Предикат для обновления списка возможных персонажей. Он исключает тех,
% у кого не совпадает текущий ответ на вопрос с имемеющимся.
% update_characters(+Characters, question(+Fact), +Reply,
% +RefreshdCharacters)
update_characters(Characters, question(Fact, _), Reply, RefreshdCharacters) :-
    include(match(Fact, Reply), Characters, RefreshdCharacters).

% Предикат, который проверяет совпадаетли ли ответ на вопрос с ожидаемым
% ответом для данного факта.
% match(+Fact, +Answer, +Character)
match(Fact, Answer, Character) :-
    character(Character, Traits),
    member(Fact-Answer, Traits).

% Предикат, который проверяет наличие ещё не заданных вопросов
unanswered_questions:-
    question(Fact, _),
    not(asked(Fact, _)),
    !.
