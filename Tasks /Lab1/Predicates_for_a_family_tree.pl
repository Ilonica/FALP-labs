man(voeneg).
man(ratibor).
man(boguslav).
man(velerad).
man(duhovlad).
man(svyatoslav).
man(dobrozhir).
man(bogomil).
man(zlatomir).

woman(goluba).
woman(lubomila).
woman(bratislava).
woman(veslava).
woman(zhdana).
woman(bozhedara).
woman(broneslava).
woman(veselina).
woman(zdislava).

parent(voeneg,ratibor).
parent(voeneg,bratislava).
parent(voeneg,velerad).
parent(voeneg,zhdana).

parent(goluba,ratibor).
parent(goluba,bratislava).
parent(goluba,velerad).
parent(goluba,zhdana).

parent(ratibor,svyatoslav).
parent(ratibor,dobrozhir).
parent(lubomila,svyatoslav).
parent(lubomila,dobrozhir).

parent(boguslav,bogomil).
parent(boguslav,bozhedara).
parent(bratislava,bogomil).
parent(bratislava,bozhedara).

parent(velerad,broneslava).
parent(velerad,veselina).
parent(veslava,broneslava).
parent(veslava,veselina).

parent(duhovlad,zdislava).
parent(duhovlad,zlatomir).
parent(zhdana,zdislava).
parent(zhdana,zlatomir).

%Предикаты, которые выводят всех мужчин, женщин и детей.
men():- man(X), print(X), nl, fail.
women():- woman(X), print(X), nl, fail.
children(X):- parent(X,Y), print(Y), nl, fail.

%Предикат, который проверяет является ли X матерью Y.
mother(X,Y):- woman(X), parent(X,Y).
%Предикат, который выводит маму X.
mother(X):- mother(Y,X), print(Y), nl, fail.

%Предикат, который проверяет является ли X братом Y.
brothers(X,Y):- man(X), man(Y), parent(Z,X), parent(Z,Y), X\=Y.
%Предикат, который выводит всех братьев X.
brothers(X):- brothers(Y,X), print(Y), nl, fail.

% Предикат, который проверяет являются ли X и Y родными братом и
% сестрой или братьями или сестрами.
b_s(X,Y):- (man(X), man(Y); man(X), woman(Y); woman(X), woman(Y)), parent(Z,X), parent(Z,Y), X\=Y.
%Предикат, который выводит всех братьев или сестер X.
b_s(X):- b_s(Y,X), print(Y), nl, fail.

%Предикат, который проверяет, является ли X отцом Y.
father(X,Y):-man(X), parent(X,Y).
%Предикат, который выводит отца X.
father(X):-father(Y,X), print(Y), nl, fail.

%Предикат, который проверяет, является ли X женой Y.
wife(X,Y):-woman(X), man(Y), parent(X,Z), parent(Y,Z), X\=Y.
%Передикат, который выводит жену X.
wife(X):-wife(Y,X), print(Y), nl, fail.

% Решение с использованием только базы фактов
% Предикат, который проверяет, является ли X внучкой Y.
grand_da(X,Y):- woman(X), parent(Y,Z), parent(Z,X).
% Передикат, который выводит всех внучек X.
grand_dats(X):- grand_da(Y,X), print(Y), nl, fail.

% Предикат, который проверяет, является ли X и Y дедушкой и внучкой или
% наоборот.
grand_pa_and_da(X,Y):- man(X), woman(Y), parent(X,Z), parent(Z,Y); man(Y), woman(X), parent(Y,Z), parent(Z,X).

% Предикат, который проверяет, является ли X тетей Y.
aunt(X,Y):- woman(X), parent(Z,D), parent(Z,X), parent(D,Y), D\=X.
% Передикат, который выводит всех теть X.
aunt(X):- aunt(Y,X), print(Y), nl, fail.

% Решение с использованием вспомогательных предикатов
% Предикат, который проверяет, являеттся ли Y дочкой X.
daughter(X,Y):- woman(Y), parent(X,Y).
% Предикат, который проверяет, является ли X внучкой Y.
grand_da1(X,Y):- parent(Y,Z), daughter(Z,X).
% Передикат, который выводит всех внучек X.
grand_dats1(X):- grand_da1(Y,X), print(Y), nl, fail.

% Предикат, который проверяет, является ли X и Y дедушкой и внучкой.
grand_fa_and_da(X,Y):- father(X,Z), daughter(Z,Y).
% Предикат, который проверяет, является ли X и Y внучкой и дедушкой.
grand_da_and_fa(X,Y):- father(Y,Z), daughter(Z,X).
% Предикат, который проверяет, является ли X и Y дедушкой и внучкой или
% наоборот.
grand_pa_and_da1(X,Y):- grand_fa_and_da(X,Y); grand_da_and_fa(X,Y).

% Предикат, который проверяет, является ли X и Y братом и сестрой или
% сестрами.
brother_and_sister(X,Y):- woman(Y), parent(Z,Y), parent(Z,X).
% Предикат, который проверяет, является ли X тетей Y.
aunt1(X,Y):- brother_and_sister(D,X), parent(D,Y), D\=X.
% Передикат, который выводит всех теть X.
aunt1(X):- aunt1(Y,X), print(Y), nl, fail.
