; inherits: c

;; The bundled C query uses a heuristic that maps ALL_CAPS identifiers to
;; @constant (pattern: ^[A-Z][A-Z0-9_]+$).  This collides with coding styles
;; like LLVM's where short uppercase names are local variables (CI, BB, MAM).
;; Override: reclassify short ALL_CAPS identifiers (2-3 chars) as @variable.
((identifier) @variable
  (#lua-match? @variable "^[A-Z][A-Z0-9_]?[A-Z0-9_]?$")
  (#set! priority 101))
