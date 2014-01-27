;; Copyright 2010 Peter K. Keller (psilord@cs.wisc.edu)
;;
;; Licensed under the Apache License, Version 2.0 (the "License"); you
;; may not use this file except in compliance with the License. You may
;; obtain a copy of the License at
;;
;; http://www.apache.org/licenses/LICENSE-2.0
;;
;; Unless required by applicable law or agreed to in writing, software
;; distributed under the License is distributed on an "AS IS" BASIS,
;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express
;; or implied. See the License for the specific language governing
;; permissions and limitations under the License.

(in-package #:option-9)

(declaim (optimize (safety 3) (space 0) (speed 0) (debug 3)))


;; Acecssors for the flying vector.
(defmethod dfvx ((f frame))
  (with-pvec-accessors (p (dfv f))
    px))

(defmethod (setf dfvx) (new-val (f frame))
  (with-pvec-accessors (p (dfv f))
    (setf px new-val)))

(defmethod dfvy ((f frame))
  (with-pvec-accessors (p (dfv f))
    py))

(defmethod (setf dfvy) (new-val (f frame))
  (with-pvec-accessors (p (dfv f))
    (setf py new-val)))

(defmethod dfvz ((f frame))
  (with-pvec-accessors (p (dfv f))
    pz))

(defmethod (setf dfvz) (new-val (f frame))
  (with-pvec-accessors (p (dfv f))
    (setf pz new-val)))


;; Accessors for the rotation vector
(defmethod drvx ((f frame))
  (with-pvec-accessors (p (drv f))
    px))

(defmethod (setf drvx) (new-val (f frame))
  (with-pvec-accessors (p (drv f))
    (setf px new-val)))

(defmethod drvy ((f frame))
  (with-pvec-accessors (p (drv f))
    py))

(defmethod (setf drvy) (new-val (f frame))
  (with-pvec-accessors (p (drv f))
    (setf py new-val)))

(defmethod drvz ((f frame))
  (with-pvec-accessors (p (drv f))
    pz))

(defmethod (setf drvz) (new-val (f frame))
  (with-pvec-accessors (p (drv f))
    (setf pz new-val)))


;; Accessors for the translation vector.
(defmethod dtvx ((f frame))
  (with-pvec-accessors (p (dtv f))
    px))

(defmethod (setf dtvx) (new-val (f frame))
  (with-pvec-accessors (p (dtv f))
    (setf px new-val)))

(defmethod dtvy ((f frame))
  (with-pvec-accessors (p (dtv f))
    py))

(defmethod (setf dtvy) (new-val (f frame))
  (with-pvec-accessors (p (dtv f))
    (setf py new-val)))

(defmethod dtvz ((f frame))
  (with-pvec-accessors (p (dtv f))
    pz))

(defmethod (setf dtvz) (new-val (f frame))
  (with-pvec-accessors (p (dtv f))
    (setf pz new-val)))


;; Accessors for the displacement vector.
(defmethod dvx ((f frame))
  (with-pvec-accessors (p (dv f))
    px))

(defmethod (setf dvx) (new-val (f frame))
  (with-pvec-accessors (p (dv f))
    (setf px new-val)))

(defmethod dvy ((f frame))
  (with-pvec-accessors (p (dv f))
    py))

(defmethod (setf dvy) (new-val (f frame))
  (with-pvec-accessors (p (dv f))
    (setf py new-val)))

(defmethod dvz ((f frame))
  (with-pvec-accessors (p (dv f))
    pz))

(defmethod (setf dvz) (new-val (f frame))
  (with-pvec-accessors (p (dv f))
    (setf pz new-val)))

;; by default, there is no decay.
(defmethod dtv-decay ((f frame) &key (decay 1d0))
  (when (not (pv-zero-p (dtv f)))
    (with-pvec-accessors (tv (dtv f))
      (psetf tvx (* tvx decay)
             tvy (* tvy decay)
             tvz (* tvz decay)))
    (pv-stabilize-into (dtv f))))

(defmethod dtv-decay ((f field-mine) &key)
  (when (not (pv-zero-p (dtv f)))
    (pv-clear-into (dtv f))))

(defmethod at-location ((destination frame) (source frame))
  (pm-copy-into (local-basis destination) (local-basis source))
  (pm-copy-into (world-basis destination) (world-basis source)))


(defmethod vulnerable ((ent entity))
  (or (null (inttl ent)) (zerop (inttl ent))))
