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
  write(NumberofPersons),nl,
	number(NumberofPersons),

	% Number of Groups %
	read(Fd,NumberofGroups),
	write(NumberofGroups),nl,
	number(NumberofGroups),

	% Number of Different Tables %
	read(Fd,NumberofDifferentTables),
	write(NumberofDifferentTables),nl,
	number(NumberofDifferentTables),

	readPersons(Fd,ListofPersons,NumberofPersons),
	readGroups(Fd,ListofGroups,NumberofGroups),
	readTables(Fd,ListofTables,NumberofDifferentTables),
	write(ListofPersons),nl,
	write(ListofGroups),nl,
	write(ListofTables),nl,

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

%------------------Read Groups----------------%
readGroups(Fd,[],0).
readGroups(Fd,[X|Xs],NumberofGroups):-
	readGroup(Fd,X),
	NextN is NumberofGroups -1,
	readGroups(Fd,Xs,NextN).

readGroup(Fd,[X|Xs]):-
	read(Fd,X),
	readPersons(Fd,Xs,X).
%-----------------Read Tables-----------------%
readTables(Fd,[],0).
readTables(Fd,[X|Xs],NumberofDifferentTables):-
	readTable(Fd,X),
	NextN is NumberofDifferentTables -1,
	readTables(Fd,Xs,NextN).

readTable(Fd,[X,Xs]):-
	read(Fd,X),
	read(Fd,Xs).

%-------------------Clear Screen--------------%
clearScreen(0).
clearScreen(N):- nl, N1 is N-1, clearScreen(N1).
