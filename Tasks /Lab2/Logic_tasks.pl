% Задание 4
% В бутылке, стакане, кувшине и банке находятся молоко, лимонад, квас
% и вода. Известно, что вода и молоко не в бутылке, сосуд с лимонадом находится между
% кувшином и сосудом с квасом, в банке - не лимонад и не вода. Стакан находится около
% банки и сосуда с молоком. Как распределены эти жидкости по сосудам.

% Проверка наличия элемента в списке
% in_list(+[Element|_], +Element))
is_in_list([Element|_], Element).
is_in_list([_|Tail], Element):- is_in_list(Tail, Element).

% Проверка, что один элемент справа от другого
% right_next(+Left, +Right, +[Left, Right|_])
right_next(Left, Right, [Left, Right|_]).
right_next(Left, Right, [_|Rest]):- right_next(Left, Right, Rest).

% Проверка, что один элемент слева от другого
% left_next(+Left, +Right, +[Right, Left|_])
left_next(Left, Right, [Right, Left|_]).
left_next(Left, Right, [_|Rest]):- left_next(Left, Right, Rest).

% Проверка соседства двух элементов
% adjacent(+X, +Y, +List)
adjacent(X, Y, List):- right_next(X, Y, List).
adjacent(X, Y, List):- left_next(X, Y, List).

% Основной предикат
solve_problem:-
    Containers = [_, _, _, _],

    % Вода и молоко не в бутылке
    (is_in_list(Containers, [bottle, kvass]); is_in_list(Containers, [bottle, lemonade])),

    % Лимонад между кувшином и квасом
    adjacent([_, lemonade], [jug, _], Containers),
    adjacent([_, lemonade], [_, kvass], Containers),

    % В банке не лимонад и не вода
    (is_in_list(Containers, [jar, kvass]); is_in_list(Containers, [jar, milk])),

    % Стакан около банки и молока
    adjacent([glass, _], [jar, _], Containers),
    adjacent([glass, _], [_, milk], Containers),

    is_in_list(Containers, [Vessel1, water]),
    is_in_list(Containers, [Vessel2, lemonade]),
    is_in_list(Containers, [Vessel3, milk]),
    is_in_list(Containers, [Vessel4, kvass]),
    write('Containers: '), write(Containers), nl.
