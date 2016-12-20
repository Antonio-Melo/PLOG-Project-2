%LIBRARIES
:- use_module(library(clpfd)).
:- use_module(library(lists)).

%Starting function
org:-
	clearScreen(40),
	write(' Welcome to Dinner Organizer!!\n By:Antonio Melo & Ariana Fernandes\n\n'),
	write('Please read the README file before using this program in order to work!\n'),
	write('Reading Input.txt file...\n'),
	readFile.




% Read File %
readFile:-
	open('Input.txt',read,Fd),
	% Number of Persons %
  read(Fd,NumberofPersons),
  write(NumberofPersons),
	number(NumberofPersons),

	% Number of Groups %
	read(Fd,NumberofGroups),
	write(NumberofGroups),
	number(NumberofGroups),

	% Number of Different Tables %
	read(Fd,NumberofDifferentTables),
	write(NumberofDifferentTables),
	number(NumberofDifferentTables),

	readPersons(Fd),
	close(Fd).

readPersons(Fd):-
	read(Fd,Name),
	write(Name).


% Clear Screen %
clearScreen(0).
clearScreen(N):- nl, N1 is N-1, clearScreen(N1).
