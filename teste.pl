:- use_module(library(lists)).
:- use_module(library(clpfd)).
 
jantar :-
    people(People),
    tables(Tables),
    length(Tables, NrTables),
    length(People, NrPeople),
    length(PersonTable, NrPeople),
    createCardinality(Tables, 0, Pairs),
    global_cardinality(PersonTable, Pairs),
    domain(PersonTable, 0, NrTables),
    labeling([], PersonTable),
    write(PersonTable).
	%length(FinalTables,NrTables),
	
	

	
   
createCardinality([], _, []).
createCardinality([T|Tables], N, [N-T|Pairs]) :-
        N1 is N+1,
        createCardinality(Tables, N1, Pairs).
 
   
tables([4,4,2]).
 
people([
%Name, Group, Religion, Profession, Hobby
['Antonio',0,0,1,0],
['Teresa',0,1,0,1],
['Vasco',0,0,1,1],
['Mora',1,0,1,1],
['Caffi',1,0,0,0],
['Gonçalo',1,1,0,1],
['Pulga',2,1,0,0],
['Maria',2,0,0,1],
['Pedro',3,0,0,1],
['Ricca',3,1,0,1]]).