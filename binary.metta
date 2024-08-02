;; Define the Tree type and its constructors
(: Tree Type) ;; Tree type definition
(: NilNode Tree) ;; An empty node

;; Define the TreeNode constructor
(: TreeNode (-> Symbol Tree Tree Tree)) ;; A node with a root symbol and two children (left and right) to make it binary tree

;; Define the Check-Symbol function to check if a symbol is present in the tree
(: Check-Symbol (-> Tree Symbol Bool))

(= (Check-Symbol NilNode $Symbol) False) ;; A symbol is not present in an empty tree
(= (Check-Symbol (TreeNode $root $left $right) $Symbol)
    (if (== $root $Symbol)
        True ;; If the root is the symbol, return True
        (or (Check-Symbol $left $Symbol) ;; Otherwise, check the left subtree
            (Check-Symbol $right $Symbol) ;; and the right subtree recursively
        )
    )
)

;; Test cases
!(Check-Symbol NilNode B) ;; False: Check if B is in an empty tree
!(Check-Symbol (TreeNode A (TreeNode B NilNode NilNode) (TreeNode C NilNode NilNode)) B) ;; True: Check if B is in the tree
!(Check-Symbol (TreeNode A (TreeNode B NilNode NilNode) (TreeNode C NilNode NilNode)) D) ;; False: Check if D is in the tree
