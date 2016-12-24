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
	readFile(NumberofPersons,NumberofDifferentTables,ListofPersons,ListofTables),
	write('File read successfully!\n'),
	write('Number of persons: '),write(NumberofPersons),nl,
	write('Number of different tables: '),write(NumberofDifferentTables),nl,
	write('Persons: '),write(ListofPersons),nl,
	write('Types of tables: '),write(ListofTables),nl,
	
	checkSeats(NumberofPersons,ListofTables),
	createListToFillTables(ListofTables,TempTables,Tables),
	write(Tables).
	fillTables(NumberofPersons,ListofPersons,Tables).
%---------------Fill Tables-------------------%
fillTables(Tables).
%------------Create Vector of Tables----------%

createListToFillTables([],_,Tables):- append([],[],Tables).
createListToFillTables([T|Ts],[E|Es],Tables):-
	nth0(0,T,NumberofTableSeats),
	nth0(1,T,NumberofTables),
	createTable(E,NumberofTableSeats,NumberofTables),
	createListToFillTables(Ts,Es,NewTables),
	append(E,NewTables,Tables).

createTable([],_,0).	
createTable([E|Es],NumberofTableSeats,NumberofTables):-
	NewNumberofTables is NumberofTables -1,
	build(_,NumberofTableSeats,E),
	createTable(Es,NumberofTableSeats,NewNumberofTables).

build(_,0,[]).  
build(X,N1,[X|L]) :- N1 > 0, N is N1 - 1, build(X,N,L). 
build(X,N1,X):- N1>0, N1 is N - 1, build(X,N,[]).  
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
readFile(NumberofPersons,NumberofDifferentTables,ListofPersons,ListofTables):-
	open('Input.txt',read,Fd),
	% Number of Persons %
	read(Fd,NumberofPersons),
	number(NumberofPersons),

	% Number of Different Tables %
	read(Fd,NumberofDifferentTables),
	number(NumberofDifferentTables),

	readPersons(Fd,ListofPersons,NumberofPersons),
	readTables(Fd,ListofTables,NumberofDifferentTables),

	close(Fd).
	
%-------------------Read Persons--------------%
readPersons(Fd,[],0).
readPersons(Fd,[X|Xs],NumberofPersons):-
	readPerson(Fd,X,2),
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