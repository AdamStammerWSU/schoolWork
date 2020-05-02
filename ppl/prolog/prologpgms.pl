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

removelast(List, R) :- List = [F | [S |Rest]], R = [
F, S].

removeph([],[]).
removeph(List, R) :- List = [Head | Rest],
                     removelast(Head, H),
					 removeph(Rest, Tail),
					 R = [H | Tail].