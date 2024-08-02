;; Define the list type and its constructors
(: NilList List) ;; An empty list
(: Cons (-> Symbol List List)) ;; A list with a head element and a tail (another list)

;; Define the Member? function to check membership of a Symbol in a List
(: Member? (-> Symbol List Bool))
(= (Member? $Symbol NilList) False) 
(= (Member? $Symbol (Cons $head $tail))
   (or (== $Symbol $head) ;; If the symbol is the head, return True
       (Member? $Symbol $tail))) ;; Otherwise, check the tail recursively


;; Define the Reverse function to reverse a list
(: Reverse (-> List List))
(= (Reverse NilList) NilList) ;; The reverse of an empty list is an empty list
(= (Reverse (Cons $head $tail))
   (Reverse-Helper $tail (Cons $head NilList))) ;; Use helper function to reverse the list

;; Define the helper function for reversing a list
(: Reverse-Helper (-> List List List))
(= (Reverse-Helper NilList $acc) $acc) ;; When the list is empty, return the accumulated result
(= (Reverse-Helper (Cons $head $tail) $acc)
   (Reverse-Helper $tail (Cons $head $acc))) ;; Recursively accumulate the reversed list



;; Define the Length function to calculate the length of a list
(: Length (-> List Number))
(= (Length NilList) 0) 
(= (Length (Cons $head $tail))
   (+ 1 (Length $tail)))


;; Define the Push-Back function to add an element at the end of the list
(: Push-Back (-> Symbol List List))
(= (Push-Back $Symbol NilList) (Cons $Symbol NilList)) ;; Adding to an empty list creates a new single-element list
(= (Push-Back $Symbol (Cons $head $tail))
   (Cons $head (Push-Back $Symbol $tail))) ;; Recursively add the element to the end


;; Define the Remove-Element function to remove a specific element from the list
(: Remove-Element (-> Symbol List List))
(= (Remove-Element $Symbol NilList) NilList) ;; Removing from an empty list returns an empty list
(= (Remove-Element $Symbol (Cons $head $tail))
   (if (== $Symbol $head)
       (Remove-Element $Symbol $tail) ;; Skip the element if it matches the head
       (Cons $head (Remove-Element $Symbol $tail)))) ;; Otherwise, keep the head and remove from the tail



;; Define the Max-Value function to find the maximum value in a list of numbers
(: Max-Value (-> List Number))
(: Max (-> Number Number Number)) ;; Define a helper function Max to find the maximum of two numbers
(= (Max $a $b) (if (> $a $b) $a $b)) ;; Return the larger of the two numbers



(= (Max-Value NilList) 0) ;; Assuming 0 as the default value for an empty list
(= (Max-Value (Num $head NilList)) $head) ;; If the list has one element, that is the max value
(= (Max-Value (Num $head $tail))
   (Max $head (Max-Value $tail))) ;; Recursively find the max value



;; Define a map function to apply a function to each element of the list
(= (map $f NilList) NilList) ;; Mapping over an empty list returns an empty list
(= (map $f (Cons $head $tail))
   (Cons ($f $head) (map $f $tail))) ;; Apply the function to the head and recursively to the tail

;; Example function to duplicate a symbol
(= (duple_it $symbol) ($symbol $symbol))



;; Example usages and tests
!(map duple_it (Cons A (Cons B (Cons C NilList)))) ;; Duplicate each element in the list
!(Member? B (Cons A (Cons B (Cons C NilList)))) ;; Check if B is a member of the list
!(Reverse (Cons A (Cons B (Cons C NilList)))) ;; Reverse the list
!(Length (Cons A (Cons B (Cons C NilList)))) ;; Get the length of the list
!(Push-Back X (Cons A (Cons B NilList))) ;; Add X to the end of the list
!(Remove-Element B (Cons A (Cons B (Cons C NilList)))) ;; Remove B from the list
!(Max-Value NilList) ;; Find the max value in an empty list
!(Max-Value (Num 3 (Num 7 (Num 2 NilList)))) ;; Find the max value in the list (3 7 2)
