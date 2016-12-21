%--------------------LIBRARIES----------------%
:- prolog:set_current_directory('C:/Users/Antonio/Desktop/PLOG-Project-2').
:- use_module(library(clpfd)).
:- use_module(library(lists)).

%--------------------Starting function--------%
org:-
	clearScreen(40),
	write(' Welcome to Dinner Organizer!!\n By:Antonio Melo & Ariana Fernandes\n\n'),
	write('Please read the README file before using this program in order to work!\n'),
	write('Reading Input.txt file...\n'),
	readFile.


%--------------------Read File----------------%
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

	readPersons(Fd,ListofPersons,NumberofPersons),
	write(ListofPersons),
	close(Fd).
%-------------------Read Persons--------------%
readPersons(Fd,[],0).
readPersons(Fd,[X|Xs],NumberofPersons):-
	readPerson(Fd,X,4),
	NextN is NumberofPersons - 1,
	readPersons(Fd,Xs,NextN).

readPerson(Fd,[],0).
readPerson(Fd,[X|Xs],N):-
	read(Fd,X),
	NextN is N - 1,
	readPerson(Fd,Xs,NextN).


%-------------------Clear Screen--------------%
clearScreen(0).
clearScreen(N):- nl, N1 is N-1, clearScreen(N1).
