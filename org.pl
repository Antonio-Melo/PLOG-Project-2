%LIBRARIES
:- use_module(library(clpfd)).

%Starting function
org:-
	clearScreen(40),
	write(' Welcome to Dinner Organizer!!\n By:António Melo & Ariana Fernandes\n\n'),
	write('Please read the README file before using this program in order to work right!\n').


		
% Clear Screen %
clearScreen(0).
clearScreen(N):- nl, N1 is N-1, clearScreen(N1).