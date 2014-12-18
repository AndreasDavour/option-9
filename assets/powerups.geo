;; -*- mode: Lisp; -*-

`(
  (:powerup-super-shot
   (:primitives
    ((:line-loop ((0d0 2d0 0d0) (1 1 1))
                 ((2d0 0d0 0d0) (1 1 1))
                 ((0d0 -2d0 0d0) (1 1 1))
                 ((-2d0 0d0 0d0) (1 1 1)))
     (:line-strip ((.5d0 .5d0 0d0) (1 1 1))
                  ((0d0 1d0 0d0) (1 1 1))
                  ((-.5d0 .5d0 0d0) (1 1 1))
                  ((.5d0 -.5d0 0d0) (1 1 1))
                  ((0d0 -1d0 0d0) (1 1 1))
                  ((-.5d0 -.5d0 0d0) (1 1 1))))))

  (:powerup-hardnose
   (:primitives
    ((:line-loop ((0d0 2d0 0d0) (1 1 1))
                 ((1d0 1d0 0d0) (1 1 1))
                 ((1d0 -1d0 0d0) (1 1 1))
                 ((0d0 -2d0 0d0) (1 1 1))
                 ((-1d0 -1d0 0d0) (1 1 1))
                 ((-1d0 1d0 0d0) (1 1 1)))
     (:lines ((.5d0 1d0 0d0) (1 1 1))
             ((.5d0 -1d0 0d0) (1 1 1))
             ((-.5d0 1d0 0d0) (1 1 1))
             ((-.5d0 -1d0 0d0) (1 1 1))
             ((-.5d0 0d0 0d0) (1 1 1))
             ((.5d0 0d0 0d0) (1 1 1))))))

  (:powerup-tesla-gun
   (:primitives
    ((:lines ((-1d0 1d0 0d0) (1 1 1))
             ((1d0 -1d0 0d0) (1 1 1))
             ((-1d0 -1d0 0d0) (1 1 1))
             ((1d0 1d0 0d0) (1 1 1))
             ((-1d0 0d0 0d0) (1 1 1))
             ((1d0 0d0 0d0) (1 1 1))))))

  (:powerup-health
   (:primitives
    ((:line-loop ((-1d0 1d0 0d0) (1 1 1))
                 ((1d0 1d0 0d0) (1 1 1))
                 ((-1d0 -1d0 0d0) (1 1 1))
                 ((1d0 -1d0 0d0) (1 1 1))))))

  (:powerup-ship-shield
   (:primitives
    ((:line-loop ((0d0 1d0 0d0) (1 1 1))
                 ((1d0 -1d0 0d0) (1 1 1))
                 ((-1d0 -1d0 0d0) (1 1 1))))))

  (:powerup-shot-shield
   (:primitives
    ((:line-loop ((.5d0 .5d0 0d0) (1 1 1))
                 ((.5d0 -.5d0 0d0) (1 1 1))
                 ((-.5d0 -.5d0 0d0) (1 1 1))
                 ((-.5d0 .5d0 0d0) (1 1 1)))
     (:line-loop ((1d0 1d0 0d0) (1 1 1))
                 ((1d0 -1d0 0d0) (1 1 1))
                 ((-1d0 -1d0 0d0) (1 1 1))
                 ((-1d0 1d0 0d0) (1 1 1)))
     (:line-loop ((1.5d0 1.5d0 0d0) (1 1 1))
                 ((1.5d0 -1.5d0 0d0) (1 1 1))
                 ((-1.5d0 -1.5d0 0d0) (1 1 1))
                 ((-1.5d0 1.5d0 0d0) (1 1 1))))))

  (:powerup-charge
   (:primitives
    ((:lines ((0d0 2d0 0d0) (1 1 1))
             ((0d0 -1d0 0d0) (1 1 1)))
     (:line-strip ((-1d0 0d0 0d0) (1 1 1))
                  ((0d0 -1d0 0d0) (1 1 1))
                  ((1d0 0d0 0d0) (1 1 1))))))


  )
