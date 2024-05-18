% Задание 5
% 1) Найти количество четных чисел, не взаимно простых с данным
% Функция для получения чисел, не взаимно простых с N
find_not_coprimes(2, []) :- !.
find_not_coprimes(N, NotCoprimes) :-
    N < 2, !,
    NotCoprimes = [].
find_not_coprimes(N, NotCoprimes) :-
    N > 2,
    find_numbers(N, 2, NotCoprimes).

find_numbers(N, N, []) :- !.
find_numbers(N, Current, [Current | NotCoprimes]) :-
    Current < N,
    \+ are_coprime(Current, N),
    Next is Current + 1,
    find_numbers(N, Next, NotCoprimes).
find_numbers(N, Current, NotCoprimes) :-
    Current < N,
    find_numbers(N, Current + 1, NotCoprimes).
find_numbers(_, N, []).

% Подсчёт количества чётных чисел в списке
count_evens([], 0).
count_evens([Head | Tail], Count) :-
    0 is Head mod 2,  % Число чётное
    count_evens(Tail, Rest),
    Count is Rest + 1.
count_evens([Head | Tail], Count) :-
    1 is Head mod 2,  % Число нечётное
    count_evens(Tail, Count).

% Подсчитать количество чётных чисел среди не взаимно простых с N
count_evens_among_not_coprimes(N, Count) :-
    find_not_coprimes(N, Numbers),
    count_evens(Numbers, Count).

% Определение взаимной простоты двух чисел
are_coprime(X, Y) :-
    gcd(X, Y, 1).

% Нахождение наибольшего общего делителя
gcd(X, Y, Result) :-
    X =:= Y,
    Result is X.
gcd(X, Y, Result) :-
    X < Y,
    Difference is Y - X,
    gcd(X, Difference, Result).
gcd(X, Y, Result) :-
    X > Y,
    gcd(Y, X, Result).


2) Найти произведение максимального числа, не взаимно простого с данным, не
делящегося на наименьший делитель исходно числа, и суммы цифр числа, меньших 5
calculate_product_of_max_non_coprime(N, Result) :-
    find_non_coprime_numbers(N, NonCoprimes),
    find_smallest_divisor(N, SmallestDivisor),
    filter_numbers_with_digit_sum_under_five(NonCoprimes, FilteredNumbers),
    filter_non_divisible_by_divisor(FilteredNumbers, SmallestDivisor, ValidNumbers),
    find_maximum(ValidNumbers, MaxNumber),
    product_of_number_digits(MaxNumber, Result).

% Найти максимум в списке
find_maximum([SingleElement], SingleElement).
find_maximum([First|Rest], Maximum) :-
    find_maximum(Rest, CurrentMax),
    (First > CurrentMax -> Maximum = First ; Maximum = CurrentMax).

% Удалить из списка числа, которые делятся на заданный делитель
filter_non_divisible_by_divisor([], _, []).
filter_non_divisible_by_divisor([Head|Tail], Divisor, [Head|Filtered]) :-
    Head mod Divisor =\= 0,
    filter_non_divisible_by_divisor(Tail, Divisor, Filtered).
filter_non_divisible_by_divisor([Head|Tail], Divisor, Filtered) :-
    Head mod Divisor =:= 0,
    filter_non_divisible_by_divisor(Tail, Divisor, Filtered).

% Найти наименьший делитель числа
find_smallest_divisor(N, Divisor) :-
    N > 1,
    iterate_to_find_divisor(N, 2, Divisor).

iterate_to_find_divisor(N, Divisor, Divisor) :-
    0 is N mod Divisor.
iterate_to_find_divisor(N, Current, Divisor) :-
    Current < N,
    Next is Current + 1,
    iterate_to_find_divisor(N, Next, Divisor).

% Удалить из списка числа, сумма цифр которых >= 5
filter_numbers_with_digit_sum_under_five([], []).
filter_numbers_with_digit_sum_under_five([Head|Tail], [Head|Result]) :-
    digit_sum_under_five(Head),
    filter_numbers_with_digit_sum_under_five(Tail, Result).
filter_numbers_with_digit_sum_under_five([_|Tail], Result) :-
    filter_numbers_with_digit_sum_under_five(Tail, Result).

% Проверка, что сумма цифр числа < 5
digit_sum_under_five(Number) :-
    sum_of_digits(Number, Sum),
    Sum < 5.

% Подсчитать сумму цифр числа
sum_of_digits(0, 0).
sum_of_digits(Number, Sum) :-
    Number > 0,
    LastDigit is Number mod 10,
    RemainingNumber is Number div 10,
    sum_of_digits(RemainingNumber, PartialSum),
    Sum is LastDigit + PartialSum.
