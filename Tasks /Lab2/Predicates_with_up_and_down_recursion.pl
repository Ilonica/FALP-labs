% Предикат, который находит максимальное число из X, Y, Z
% max(+X, +Y, +U, -Z)
max(X, Y, U, X) :- X>Y, X>U, !.
max(_, Y, U, Y) :- Y>U, !.
max(_,_,U,U).

% Предикат, который находит факториал первого аргумента (рекурсия вверх)
% fact_up(+N, -X)
fact_up(0, 1) :- !.
fact_up(N, X) :- N1 is N - 1, fact_up(N1, X1), X is N*X1.

% Предикат, который находит факториал первого аргумента (рекурсия вниз)
% fact_down(+N, -X)
fact_down(N, X) :- fact_down(0, 1, N, X).
fact_down(N, Z, N, Z) :- !.
fact_down(N,_,N,_):-!,fail.
fact_down(Y, Z, N, X) :- Y1 is Y + 1, Z1 is Z*Y1, fact_down(Y1, Z1, N, X).

% Предикат, который находит сумму цифр числа (рекурсия вверх)
% digit_sum_up(+X, -Sum)
digit_sum_up(0,0):-!.
digit_sum_up(X,Sum):-X1 is X // 10, Rem is X mod 10, digit_sum_up(X1, Sum1), Sum is Sum1 + Rem.

% Предикат, который находит сумму цифр числа (рекурсия вниз)
% digit_sum_down(+X, -Sum)
digit_sum_down(X, Sum) :- digit_sum_down(X, 0, Sum).
digit_sum_down(0, SumCur, SumCur) :- !.
digit_sum_down(X1, SumCur, Sum) :- X2 is X1 // 10, Rem is X1 mod 10, SumNew is SumCur + Rem, digit_sum_down(X2, SumNew, Sum).

% Предикат, который проверяет является ли число свободным от квадратов
% free_of_squares(+X)
free_of_squares(X) :- X>1, not(free_of_squares(2, X)).
free_of_squares(N, X) :- N *N =< X,(
0 is mod(X, N*N); N1 is N + 1,
                          free_of_squares(N1, X)).

% Предикат, котрый считывает список с клавиатуры
% read_list(-List)
read_list(List) :- read_list([], List).
read_list(Acc, List) :-
    write('Введите элемент (или нажмите Enter для завершения): '),
    read_line_to_string(user_input, Input),
    (Input = "" ->
    reverse(Acc, List); (atom_number(Input, Element) ->  true
    ;   Element = Input),
        append(Acc, [Element], NewAcc),
        read_list(NewAcc, List)).

% Предикат, который выводит список на экран
% write_list(+List)
write_list([]) :- !.
write_list([H|Tail]) :- write(H), nl, write_list(Tail).

% Предикат, который проверяет, является ли Summ суммой элементов списка
% или записывает в эту переменную сумму элементов (рекурсия вниз)
% sum_list_down(+List, ?Summ)
sum_list_down(List, Summ) :- sum_list_down(0, List, Summ).
sum_list_down(Acc, [], Acc).
sum_list_down(Acc, [H|Tail], Summ) :- NewAcc is Acc + H, sum_list_down(NewAcc, Tail, Summ).

% Предикат, который проверяет, является ли Summ суммой элементов списка
% или записывает в эту переменную сумму элементов (рекурсия вверх)
% sum_list_up(+List, ?Sum)
sum_list_up([], 0).
sum_list_up([H|T], Sum) :- sum_list_up(T, AccSum), Sum is AccSum + H.

% Предикат, который удаляет все элементы, сумма цифр которых равна
% данной
% del_items_with_sum_digits_of_X(+List, +Sum, -Result)
del_items_with_sum_digits_of_X([], _, []).
del_items_with_sum_digits_of_X([H|T], Sum, Result) :-
    digit_sum_up(H, DigitSum),
    (DigitSum =:= Sum -> 
    del_items_with_sum_digits_of_X(T, Sum, Result)
    ;   Result = [H|NewResult],
        del_items_with_sum_digits_of_X(T, Sum, NewResult)).

% Основной предикат
main :-
    read_list(List),
    write_list(List),
    sum_list_down(List, Sum),
    write(Sum), nl,
    del_items_with_sum_digits_of_X([17, 5, 28, 9, 157], 8, Result),
    write(Result).
