(in-package :option-9)

(declaim (optimize (safety 3) (space 0) (speed 0) (debug 3)))

(defun lerp (a b interp &key truncp)
  "Perform a mathematically stable linear interpolation from A to B by INTERP.
The keyword argument TRUNCP indicates if the result should be TRUNCATed or not."
  (let ((result (+ (* (- 1.0 interp) a) (* interp b))))
    (if truncp (truncate result) result)))

(defun in-usecs (seconds)
  "Convert a floating point value denoting SECONDS into an equivalent
integer of usecs and return it."
  (truncate (* seconds 1000000)))

(defmethod distance ((a frame) (b frame) &key (sqrt t))
  (let ((ao (matrix-translate-get (world-basis a)))
        (bo (matrix-translate-get (world-basis b))))
    (pv-dist ao bo :sqrt sqrt)))

(defun random-sign ()
  (if (zerop (random 2)) 1d0 -1d0))

(defun random-delta (&key (velocity .02d0))
  (* (random velocity) (random-sign)))

(defun random-in-range (start end)
  "Produce a random integer in the range specified."
  (+ start (random (+ 1 (abs (- end start))))))

(defun clamp (val minimum maximum)
  "Clamp VAL into the range MINIMUM and MAXIMUM."
  (cond
    ((< val minimum)
     minimum)
    ((> val maximum)
     maximum)
    (t
     val)))

;; From LOL
(defun group (lst n)
  (when (zerop n) (error "A zero group size is illegal"))
  (labels ((rec (lst acc)
             (let ((rst (nthcdr n lst)))
               (if (consp rst)
                   (rec rst (cons (subseq lst 0 n)
                                  acc))
                   (nreverse
                    (cons lst acc))))))
    (if lst (rec lst nil) nil)))

;; Not all of this is used, it is here because it is the full
;; utility macro sketch of hash table utilities.
;; Help with making initialized hash tables.
(defun miht-set-key/value (key value ht)
  `(setf (gethash ,key ,ht) ,value))

(defun miht-make-hash-table (&rest args)
  (if (equal args '(nil))
      `(make-hash-table)
      `(make-hash-table ,@args)))

;; use like:
;; (make-initialized-hash-table (:test #'equal) :a 0 :b 1 :c 2 ....)
;; The init-forms or keys/values can be empty if desired.
(defmacro make-initialized-hash-table ((&rest init-form) &body keys/values)
  (let ((h (gensym)))
    `(let ((,h ,(apply #'miht-make-hash-table init-form)))
       ,@(mapcar #'(lambda (key/value)
                     (when (= (length key/value) 1)
                       (error "make-initalized-hash-table: Please supply a value for key ~S"
                              (car key/value)))
                     (destructuring-bind (key value) key/value
                       (miht-set-key/value key value h)))
                 (group keys/values 2))
       ,h)))

;; Shorter helper macros for more brevity
(defmacro miht ((&rest init-form) &body keys/values)
  `(make-initialized-hash-table (,@init-form) ,@keys/values))

;; Really short macros for common cases.
(defmacro mihteq (&body keys/values)
  `(make-initialized-hash-table (:test #'eq) ,@keys/values))

(defmacro mihteql (&body keys/values)
  `(make-initialized-hash-table (:test #'eql) ,@keys/values))

(defmacro mihtequal (&body keys/values)
  `(make-initialized-hash-table (:test #'equal) ,@keys/values))

(defmacro mihtequalp (&body keys/values)
  `(make-initialized-hash-table (:test #'equalp) ,@keys/values))


(defun timestamp-subtract (x y)
  "Perform (- X Y) with the LOCAL-TIME objects and return +/- usec of the
difference.

Inspired from: http://www.gnu.org/savannah-checkouts/gnu/libc/manual/html_node/Elapsed-Time.html"
  (let* ((sx (local-time:timestamp-to-unix x))
         (ux (truncate (local-time:nsec-of x) 1000)) ; convert nsec to usec
         (sy (local-time:timestamp-to-unix y))
         (uy (truncate (local-time:nsec-of y) 1000))) ; convert nsec to usec

    (cond
      ((< ux uy)
       (let ((nsec (1+ (truncate (- uy ux) 1000000))))
         (psetf uy (- uy (* nsec 1000000))
                sy (+ sy nsec)))))

    (cond
      ((> (- ux uy) 1000000)
       (let ((nsec (truncate (- ux uy) 1000000)))
         (psetf uy (+ uy (* nsec 1000000))
                sy (- sy nsec)))))

    (let ((sr (- sx sy))
          (ur (- ux uy)))
      ;; Return the +/- difference in usec.
      (+ (* sr 1000000) ur))))

;; TODO: This math utility needs a better home and memory optimization.
(defun dist-line-point (s e p)
  "Find the shortest distance from point P to the infinite line
defined by the start point S to the end point E. S, E, P are all
pvectors which happen to be used as points."

  ;; See this page:
  ;; http://geomalgorithms.com/a02-_lines.html#Distance-to-Infinite-Line
  ;; This implements the d(P, L) equation.

  (let* (;; Compute the vector l from the two points: l = e - s
         (l (pv-sub e s))
         ;; Compute the vector w from the line starting from s and ending at p
         (w (pv-sub p s))
         ;; Compute the cross product of l and w
         (lw-cross (pv-cross l w))
         ;; Get the magnitude of lw-cross
         (lw-cross-mag (pv-mag lw-cross))
         ;; Then compute the magnitiude of l
         (l-mag (pv-mag l)))

    ;; Now, compute the distance and return it
    (/ lw-cross-mag l-mag)))
