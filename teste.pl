:- use_module(library(lists)).
:- use_module(library(clpfd)).
 
jantar :-
    people(People),
    tables(Tables),
    length(Tables, NrTables),
    length(People, NrPeople),
    length(PersonTable, NrPeople),
	%createCardinality(Tables, 0, Pairs),
	%write(Pairs),nl,
    %global_cardinality(PersonTable, Pairs),
    domain(PersonTable, 0, NrTables),
	
    labeling([], PersonTable),
    write(PersonTable).
	%length(FinalTables,NrTables),
	
zebra(Zeb,Agu) :-
Nac = [Ing, Esp, Nor, Ucr, Por],
Ani = [Cao, Rap, Igu, Cav, Zeb],
Beb = [Sum, Cha, Caf, Lei, Agu],
Cor = [Verm, Verd, Bran, Amar, Azul],
Tab = [Che, Win, LS, SG, Mar],
append([Nac,Ani,Beb,Cor,Tab], List),
%
domain(List,1,5),
all_different(Nac), all_different(Ani), all_different(Beb),
all_different(Cor), all_different(Tab),
Ing #= Verm, Esp #= Cao, Nor #= 1, Amar #= Mar,
abs(Che-Rap) #= 1, abs(Nor-Azul) #= 1,
Win #= Igu, LS #= Sum, Ucr #= Cha, Por #= SG,
abs(Mar-Cav) #= 1,
Verd #= Caf, Verd #= Bran+1, Lei #= 3,
%
labeling([],List).	

	
   
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