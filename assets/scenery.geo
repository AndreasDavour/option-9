;; -*- mode: Lisp; -*-

`(

  (:spark-1
   (:primitives
    ((:line-loop ((-.5d0 0d0 0d0) (.5 .5 .4))
                 ((0d0 .5d0 0d0) (.5 .5 .4))
                 ((.5d0 0d0 0d0) (.5 .5 .4))))))

  (:spark-2
   (:primitives
    ((:line-loop ((-.5d0 0d0 0d0) (.5 .5 .4))
                 ((0d0 -.5d0 0d0) (.5 .5 .4))
                 ((0d0 0d0 0d0) (.5 .5 .4))
                 ((.5d0 0d0 0d0) (.5 .5 .4))
                 ((0d0 .5d0 0d0) (.5 .5 .4))))))

  (:spark-3
   (:primitives
    ((:line-loop ((0d0 .5d0 0d0) (.5 .5 .4))
                 ((-.5d0 0d0 0d0) (.5 .5 .4))
                 ((.5d0 0d0 0d0) (.5 .5 .4))
                 ((0d0 -.5d0 0d0) (.5 .5 .4))))))

  )