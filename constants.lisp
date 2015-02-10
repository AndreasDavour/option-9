(in-package #:option-9)

(declaim (optimize (safety 3) (space 0) (speed 0) (debug 3)))

;; I do some velocity computations for constants at compile time in macros..
(eval-when (:compile-toplevel :load-toplevel :execute)
  ;; Timestep simulation variables for fixed, but uncoupled, time steps.
  ;; simulation frequency in Hertz
  (defparameter *hz* 60d0)
  ;; a single unit of time in seconds
  (defparameter *dt* (/ 1d0 *hz*))
  ;; a single unit of time in usecs.
  (defparameter *dt-us* (* *dt* 1000000d0)))

(defun %? (the-keyword)
  "Lookup a constant represented by a keyword and return its
numeric value.

Generally (and I should have the macro verify this naming scheme):
 :v-* means a velocity of units / second
 :r-* means a rotation of radians / second
 :c-* just means a straight up constant value"

  (flet ((per-hz (val)
           ;; Because I'm using a fixed timestep, figure out the incremental
           ;; rate for the fixed update hertz I am using.
           (/ val *hz*)))


    (ecase the-keyword
      ;; these values are velocities in units per second
      (:v-zero (per-hz 0d0))

      ;; TODO: Lift these into the player instance itself and put into
      ;; asset files.
      (:v-generic-player-forward (per-hz 80d0))
      (:v-generic-player-backward (per-hz -80d0))
      (:v-generic-player-left (per-hz -80d0))
      (:v-generic-player-right(per-hz 80d0))

      ;; These values are radians per second

      ;; These are just named constants not per hz or anything

      )))

(defmacro ? (expr)
  "Lookup a constant represented by a literal keyword or an expression
which returns a literal keyword and return its numeric value. If EXPR
is a literal keyword, compute the constant at compile-time, otherwise
it will be computed at run-time. I'm going to be struck blind by
writing this macro and then thrown into hell for naming it thusly."
  (if (keywordp expr)
      ;; if the argument is a literal keyword, we win, compute the
      ;; value at compile-time and return the literal value.
      (%? expr)
      ;; otherwise, we assume the user is passing in an expression
      ;; which returns a keyword, so rewrite it to the lower level
      ;; call function call that'll do the work with the evaluated
      ;; expression.
      `(%? ,expr)))