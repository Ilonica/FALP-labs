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
