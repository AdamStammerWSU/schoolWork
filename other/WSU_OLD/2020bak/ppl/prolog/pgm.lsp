(setq l '(a b c))

; a function to find the last item in the list
(defun mylast (l)
  (cond
    ((null l) nil)
    ((null (cdr l)) (car l))
    (t (mylast (cdr l)))

  )

)
; count
(defun mycount (l)
  (cond
    ((null l) 0)
    (t (+ 1 (mycount (cdr l))))
  )
)

; ascending




; concatenate two lists


(defun add (l1 l2)

  (cond
      ((null l1) l2)
      (t (cons (car l1) (add (cdr l1) l2)))
  )
)

(defun makepair (l)
  (list l l)
)

; pair list items
; Ex:(pair '(a b (c d) e f)))  => ( (a a) (b b) ( (c d) (c d) ) (e e) (f f))

; what is the pair operation for the default case '() => '()
; for the default case => (create pair of the first element) and cons it
; to the result of pairing for the rest 

(defun pair (l)

      (cond
          ; if the list l is empty - the result is empty
         ( (null l) '() )
    
         (t  (cons  (makepair (car l)) (pair (cdr l)) ) )

      )
)



; substitute a value for another in the list

(setq a1 'p)
(setq a2 'r)

; (substitute a1 a2 l) - a1 substitutes for a2 in l
;(setq  mylist '(1 2 3 r m s) )

(defun myfind (first inputlist) ; find and return t if first is in inputlist

     (cond
        ( (null inputlist) nil)  

        ((equal first (car inputlist) ) t)

        (t (myfind first (cdr inputlist))  )
     )
)

; if first is an atom that is being looked in find
; then first ask if the car of inputlist is atom, and then check for
; equivalence and return true - or continue search on cdr inputlist
; if the first item is a list, then do a (myfind first (car inputlist))






; (generate and test)

; formula to be calculated (x + y * z)
; operations are always of the form where the first label in a list
; is the operation name, followed by a list of arguments

; how am I going to use the add function?

; (add '(1 2 3)) => add the items in the list - 6
; (add '(1 2 3)) => concatenate - 123

;(defun add (mylist)
;  (cond ((null mylist) '())
;  ((equal (add (cdr mylist) (cdr (cdr mylist))) '(1 1))        t)
;  
;  
;  )
;
;)


; write a lisp function to substitute x for y in list
;
;
(defun mysub (x y mylist)

     (cond  
         ( (null mylist) '())
        ; ( (equal y (car mylist)) (cons x (cdr mylist)) )
         ( (equal y (car mylist)) (cons x (mysub x y (cdr mylist))) )
         ( (listp (car mylist)) (cons (mysub x y (car mylist)) (mysub x y (cdr mylist))))
         ( (cons (car mylist) (mysub x y (cdr mylist)) )  )

     )
)




; given a list identify any duplicates
(defun dupes (mylist)

    (cond ((null mylist) '()) ; return an empty list if the list is empty
        ; look for the first element in the rest of the list
        ((myfind (car mylist) (cdr mylist)) (cons (car mylist) (dupes (cdr mylist))))
        ; add it to the returned list if it is repeated
        ; keep looking for dupes in the rest of the list
        ((dupes (cdr mylist)))
        ; so an empty list is returned and dupes are added to it as it gets returned
    )
)

; given a list identify if there are any duplicates
(defun dupesBool (mylist)

    (cond ((null mylist) '())
        ;((myfind (car mylist) (cdr mylist)) t)
        ((myfind (car mylist) (cdr mylist)) t)
        ((dupes (cdr mylist)))
        
    )
)


; given a list identify unique values from the list (atoms)
(defun uniqident (mylist)
    (cond ((null mylist) '()) ; no unique values in an empty list
        ((not (dupesBool mylist) ) mylist) ;return the whole list if it doesn't contain duplicates
        ((myfind (car mylist) (cdr mylist)) (uniqident (cdr mylist)) )
        (   (not (myfind (car mylist) (cdr mylist)))    (cons (car mylist) (uniqident (cdr mylist)))   )      
    )
)



;LISP HOMEWORK:

;Assume a list is given that expresses a boolean expression. The expression follows a
;prefix format as described.

;(and p1 p2 p3) - for (p1 and p2 and p3); (or p4 p5) - for (p4 or p5)
;(not p6) - for !p6.

;p1 ... p6 are boolean expressions!

;A truth set containing the truth values of propositions is given as follows
;( (a t) (b f) (c t)) - where the propsitions a is true, b is false, and c is true.

;Define a LISP function such that returns the evaluated value (T or NIL) of the 
;boolean expression for the given truth set.

;(Hint: write independent functions for processing and, or, and not expressions
;and use them as needed during evaluation).

;For testing purpose - you can do the following

(setq expr '(and (or a b) (not c) (and b (not d))))
;(setq tset '( (a t) (b t) (c f) (d t)))

(defun truthList (mylist)
    (cond   ((null mylist) '())
            ;grab the truth values from each variable
            (T (cons (car (cdr (car mylist))) (truthlist (cdr mylist))    ))
    )
    
)

(defun myNOT (mylist)
    (cond   ((null mylist) '())
            ;if it's true return return false
            ((equal (car mylist) 'F)  (cons 'T (myNOT (cdr mylist))))
            ;if false return true
            ((equal (car mylist) 'T)  (cons 'F (myNOT (cdr mylist))))
            ; both followed by the recursively checking the rest
    )
)
(defun myOR (mylist) 
    (cond   ((null mylist) 'F)
            ;if it's false, just keep checking
            ((equal (car mylist) 'F) (myOR (cdr mylist)))
            ; if it's true return true (it only takes one)
            ((equal (car mylist) 'T) T)
    )
)
(defun myAND (mylist)
    (cond   ((null mylist) T)
            ;just one false will return false
            ((equal (car mylist) 'F) 'F)
            ; if it's true keep checking for falses
            ((equal (car mylist) 'T) (myAND (cdr mylist)))
    )
)

(defun evalexp (expr tset)
    (cond ((NULL expr) '())
            ;pass the truthlist through to the proper evaluation function
            ((equal expr 'and) (myAND (truthlist tset)))
            ((equal expr 'or) (myOR (truthlist tset)))
            ((equal expr 'not) (myNOT (truthlist tset)))
    
    )



)  
