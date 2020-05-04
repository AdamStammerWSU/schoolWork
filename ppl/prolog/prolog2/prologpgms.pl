father(john,mary).
father(gary, joe).

parent(X,Y) :- father(X,Y).

list1([a, b, c, d]).

mylast(List,X) :- List = [X].

mylast(List,X) :- List = [Head | Rest], mylast(Rest, X).

insertlast(List, X, Result) :- List = [], Result =[X].
insertlast(List, X, Result) :- List = [H | Rest],
                insertlast(Rest, X, Temp),
				Result = [H | Temp].

myexists(List, X) :- List = [X].
myexists(List, X) :- List = [X | Rest].
myexists(List, X) :- List = [Head | Rest], myexists(Rest, X).

myremove(List, X, R) :- List = [X], R = [].
myremove(List, X, R) :- List = [X | Rest], R = Rest.
myremove(List, X, R) :- List = [Head | Rest],
                     myremove(Rest, X, Temp),
					 R = [Head | Temp].



mygt(X, Y) :- X > Y.

/* find max */

findmax(List, Max) :- List = [X], Max = X.

/* findmax ([X], X). */

findmax(List, Max) :- List = [Head | Rest],
                      findmax(Rest, TempMax),
					  TempMax > Head, Max = TempMax.

findmax(List, Max) :- List = [Head | Rest],
                      findmax(Rest, TempMax),
					  Max = Head.					  
					  


/* selection sort using insertlast and findmax*/

selectsort([X],[X]).
selectsort(List, Result) :- findmax(List, Max), 
                            myremove(List, Max, Temp),
							selectsort(Temp, Backup),
							insertlast(Backup, Max, Result).

myeq(X, Y) :- X = Y.

mytestlist([4,3,88,6,7,55, 32]).

countitems([],0).
countitems(List, R) :- List = [Head | Rest], countitems(Rest, T), R = T+1.

sumitems([],0).
sumitems(List, R) :- List = [Head | Rest], sumitems(Rest, T), R = T+Head.

tuples([[john, wiley, 4444],[oscar, johnston, 74747], [gene, mccarthy, 6467]]).

removelast(List, R) :- List = [F | [S |Rest]], R = [F, S].

removeph([],[]).
removeph(List, R) :- List = [Head | Rest],
                     removelast(Head, H),
					 removeph(Rest, Tail),
					 R = [H | Tail].

append( [], X, X).                                   
append( [X | Y], Z, [X | W]) :- append( Y, Z, W).

filledList(X) :- X \= [].

t(a, t).
t(b, f).
t(c, f).

truth(X, Y). :- t(X, Y).
disect(List, H, R) :- List = [Head | Rest], H = Head, R = Rest.

truthLookup([], V) :- false.
truthLookup(TList, V) :- TList = [Head | Rest], disect(Head, H, R), ((H = V) -> ((R = [t]) -> (true); (false)) ; truthLookup(Rest, V)).
					 
/*truthlist(List, V) :- List = [ [Head | T] | Rest], append(V, T, Z), (filledList(Rest) -> truthlist(Rest, Z), V = Z).*/


myAnd([], TList) :- true.
myAnd(List, TList) :- List = [Head | Rest], (truthLookup(TList, Head) -> myAnd(Rest, TList) ; false).

myOr([], TList) :- false.
myOr(List, TList) :- List = [Head | Rest], (truthLookup(TList, Head) -> true ; myOr(Rest, TList)).

myNot(List, TList) :- List = [Head | Rest], (truthLookup(TList, Head) -> false ; true).

		
evalb(List) :- List = [Head | Rest], ((Head = and) -> (myAnd(Rest)) ; ((Head = or) -> (myOr(Rest)) ; (myNot(Rest)))).





























						