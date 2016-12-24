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
	readFile(NumberofPersons,ListofPersons,ListofTables),
	write('File read successfully!\n'),
	write('Number of persons: '),write(NumberofPersons),nl,
	write('Persons: '),write(ListofPersons),nl,
	write('Types of tables: '),write(ListofTables),nl,
	
	checkSeats(NumberofPersons,ListofTables),
	getTotalNumberofSeats(ListofTables,NumberofTables),
	length(Tables,NumberofTables),
	%write(Tables),nl,
	fillTables(NumberofPersons,ListofPersons,NumberofTables,Tables),
	write('Printing Tables...'),nl,
	printTables(Tables,ListofPersons).
%---------------Print Tables------------------%
printTables([],_):- nl.
printTables([L,Li|Ls],ListofPersons):-
	 getNameById(L,ListofPersons,Name),
	 getNameById(Li,ListofPersons,Namei),
	 write([Name,Namei]),nl,
	 printTables(Ls,ListofPersons).
	 
%--------------------People-------------------%
getNameById(Id,ListofPersons,Name):-
	nth1(Id,ListofPersons,[Name,_,_,_,_]).
	

%---------------Fill Tables-------------------%
fillTables(NumberofPersons,ListofPersons,NumberofTables,Tables):-
	domain(Tables,1,NumberofPersons),
	all_different(Tables),
	%write(NumberofTables),nl,
	restrictions(Tables,1,NumberofTables,NumberofPersons,ListofPersons),
	labeling([],Tables),
	write(Tables),nl.
%----------------Restrictions-----------------%
restrictions(Tables,Index,NumberofTables,NumberofPersons,ListofPersons):-
	Index >= NumberofTables.
restrictions(Tables,Index,NumberofTables,NumberofPersons,ListofPersons):-
	Index < NumberofTables,
	element(Index,Tables,P),
	%write(P),nl,
	NextInd is Index +1,
	element(NextInd,Tables,Pi),
	%write(Pi),nl,
	NextIndex is NextInd +1,
	P #\= Pi,
	nth1(P,ListofPersons,[N,Id,GId,Int,H]),
	%write(Int),nl,
	nth1(Pi,ListofPersons,[Ni,Idi,GIdi,Inti,Hi]),
	%write(Inti),nl,
	(GId \= 0 -> GId #= GIdi;Int #= Inti #\/ H #= Hi),
	restrictions(Tables,NextIndex,NumberofTables,NumberofPersons,ListofPersons).

%--------------Check Seats--------------------%
checkSeats(NumberofPersons,ListofTables):-
	getTotalNumberofSeats(ListofTables,NumberofSeats),
	NumberofPersons > NumberofSeats,
	write('Not Enough seats to alocate every one...\n').
	
checkSeats(NumberofPersons,ListofTables):-
	getTotalNumberofSeats(ListofTables,NumberofSeats),
	NumberofPersons =< NumberofSeats,
	write('Enough seats to alocate every one...\n').
%-------------------Tables-------------------%
getTotalNumberofSeats([],0).
getTotalNumberofSeats([T|Ts],NumberofSeats):-
	getTotalNumberofSeats(Ts,N2),
	nth0(0,T,NumberofTableSeats),
	nth0(1,T,NumberofTables),
	TempNumber is NumberofTableSeats * NumberofTables,
	NumberofSeats is N2 + TempNumber.	
%--------------------Read File----------------%
readFile(NumberofPersons,ListofPersons,ListofTables):-
	open('Input.txt',read,Fd),
	% Number of Persons %
	read(Fd,NumberofPersons),
	number(NumberofPersons),

	% Number of Different Tables %
	%read(Fd,NumberofDifferentTables),
	%number(NumberofDifferentTables),

	readPersons(Fd,ListofPersons,NumberofPersons),
	readTables(Fd,ListofTables,1),

	close(Fd).
	
%-------------------Read Persons--------------%
readPersons(Fd,[],0).
readPersons(Fd,[X|Xs],NumberofPersons):-
	readPerson(Fd,X,5),
	NextN is NumberofPersons - 1,
	readPersons(Fd,Xs,NextN).

readPerson(Fd,[],0).
readPerson(Fd,[X|Xs],N):-
	read(Fd,X),
	NextN is N - 1,
	readPerson(Fd,Xs,NextN).
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