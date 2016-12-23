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
	readFile(NumberofPersons,NumberofGroups,NumberofDifferentTables,ListofPersons,ListofGroups,ListofTables),
	write('File read successfully!\n'),
	write('Number of persons: '),write(NumberofPersons),nl,
	write('Number of groups: '),write(NumberofGroups),nl,
	write('Number of different tables: '),write(NumberofDifferentTables),nl,
	write(ListofPersons),nl,
	write(ListofGroups),nl,
	write(ListofTables),nl,
	
	checkSeats(NumberofPersons,ListofGroups,ListofTables).
	
%--------------checkPlaces--------------------%
checkSeats(NumberofPersons,ListofGroups,ListofTables):-
	getNumberofPersonsinGroup(ListofGroups,NumberofPersonsinGroup),
	write(NumberofPersonsinGroup),nl,
	getTotalNumberofSeats(ListofTables,NumberofSeats),
	write(NumberofSeats),nl,
	TotalNumberofPersons is NumberofPersons + NumberofPersonsinGroup,
	TotalNumberofPersons > NumberofSeats,
	write('Not Enough seats to alocate every one...\n').
	
checkSeats(NumberofPersons,ListofGroups,ListofTables):-
	getNumberofPersonsinGroup(ListofGroups,NumberofPersonsinGroup),
	write(NumberofPersonsinGroup),nl,
	getTotalNumberofSeats(ListofTables,NumberofSeats),
	write(NumberofSeats),nl,
	TotalNumberofPersons is NumberofPersons + NumberofPersonsinGroup,
	TotalNumberofPersons =< NumberofSeats,
	write('Enough seats to alocate every one...\n').

%-------------------Groups--------------------%
getNumberofPersonsinGroup([],0).
getNumberofPersonsinGroup([G|Gs],NumberofPersonsinGroup):-
	getNumberofPersonsinGroup(Gs,N2),
	nth0(0,G,Num),
	%write(Num).
	NumberofPersonsinGroup is N2 + Num.
%-------------------Tables-------------------%
getTotalNumberofSeats([],0).
getTotalNumberofSeats([T|Ts],NumberofSeats):-
	getTotalNumberofSeats(Ts,N2),
	nth0(0,T,NumberofTableSeats),
	nth0(1,T,NumberofTables),
	TempNumber is NumberofTableSeats * NumberofTables,
	NumberofSeats is N2 + TempNumber.

%--------------------Read File----------------%
readFile(NumberofPersons,NumberofGroups,NumberofDifferentTables,ListofPersons,ListofGroups,ListofTables):-
	open('Input.txt',read,Fd),
	% Number of Persons %
	read(Fd,NumberofPersons),
	number(NumberofPersons),

	% Number of Groups %
	read(Fd,NumberofGroups),
	%write(NumberofGroups),nl,
	number(NumberofGroups),

	% Number of Different Tables %
	read(Fd,NumberofDifferentTables),
	%write(NumberofDifferentTables),nl,
	number(NumberofDifferentTables),

	readPersons(Fd,ListofPersons,NumberofPersons),
	readGroups(Fd,ListofGroups,NumberofGroups),
	readTables(Fd,ListofTables,NumberofDifferentTables),

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
