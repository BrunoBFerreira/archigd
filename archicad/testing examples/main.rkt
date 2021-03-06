#lang racket
;(provide (except-out (all-defined-out)))

(require "../install.rkt")
(require "../communication.rkt")
(require "../geometry.rkt")
(require "../objects.rkt")
(require "../messages.rkt")
(require "../inspector.rkt")
(require "../protobuf1/protobuf.rkt")
(require "../protobuf1/syntax.rkt")
(require "../protobuf1/encoding.rkt")
(require "../../base/utils.rkt"
         "../../base/coord.rkt"
         "../../base/connection.rkt")
(require srfi/26)

(provide (all-defined-out)
         (all-from-out "../communication.rkt"
                       "../geometry.rkt"
                       "../objects.rkt"
                       "../inspector.rkt"
                       "../../base/utils.rkt"
                       "../../base/coord.rkt"
                       "../../base/connection.rkt"))

(define do-not-install? #f)
(define (do-not-install! bool)
  (set! do-not-install? bool))
(unless do-not-install?
  (move-addon))

(define (view-3d)
  (write-msg-name "3D"))

;(send (open-file "D:\\GitHubRep\\Tese\\Development\\Examples\\Models\\AT for eCADDe.pln"))
;(send (open-file "D:\\GitHubRep\\Tese\\Development\\Examples\\Models\\AT for eCADDe.ifc"))
;(send (open-file "C:\\Users\\Client\\Desktop\\SmallTower.ifc"))
(define (open-file path)
  (let ((msg (openmessage* #:path path
                           #:extension (last (string-split path ".")))))
    (write-msg "OpenFile" msg)))

(define (create-layer name)
  (let ((msg (layermsg* #:name name)))
    (write-msg "Layer" msg)))

(define (layer/element name guid)
  (let ((msg (layerelementmsg* #:layer name
                               #:guid guid)))
    (write-msg "LayerElem" msg)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Function to create a Lemon
(define (create-lemon)
  (write-msg-name "Lemon"))

;;Function to create a Chapel no communication
(define (create-chapel-no-com)
  (write-msg-name "ChapelNoCom"))

;(provide (all-defined-out))

;;TEST FUNCTION
(define (test-function)
  (write-msg-name "Test")
  ;;(elementid-guid (read-sized (cut deserialize (elementid*) <>)input))
  )
(define (test-function-msg msg)
  (write-msg "Test" msg))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Defines to help with Demos
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define tmat (list 1 0 0
                   0 0 0 
                   -1 0 0 
                   1 0 0))
(define lstpoints (list (xy 0.0 0.0) 
                        (xy 0.4 5.0) 
                        (xy 1.0 5.0)
                        (xy 1.0 6.0)
                        (xy 1.7 6.0)
                        (xy 1.7 7.0)
                        (xy 2.4 7.0)
                        (xy 2.4 7.4)
                        (xy 0.0 7.7)
                        (xy 0.0 8.0)
                        (xy 8.0 10.0)
                        (xy 12.0 0.0)
                        (xy 0.0 0.0)))
(define lstarcs (list (list 1 2 -0.143099565651258 )
                      (list 10 11 0.566476134070805)
                      (list 11 12 0.385936923743763)))
(define hpoints (list (xy -1.5 -0.3) 
                      (xy -1.5 3.1) 
                      (xy 1.5 3.1)
                      (xy 1.5 -0.3)
                      (xy -1.5 -0.3)))
(define harcs (list (list 2 3 (* -240 DEGRAD))))
(define hheight -5.2)
(define htmat (list 1 0 0 0 
                    0 1 0 0
                    0 0 1 10))

(define cPoints (list (xy 0.0 0.0)
                      (xy 0.0 10.0)
                      ;;(xy 10.0 10.0)
                      ;;(xy 10.0 0.0)
                      (xy 0.0 0.0)
                      ))

(define cArcs (list (* 90 DEGRAD)
                    (* 90 DEGRAD)
                    ))

(define (eight-spheres)
  (sphere 0.0 0.0 0.0001 0.0 0.0)
  (sphere 0.0 0.0 0.0001 0.0 1.0)
  (sphere 0.0 0.0 0.0001 0.0 -1.0)
  
  (sphere 0.0 0.0 0.0001 1.0 1.0)
  (sphere 0.0 0.0 0.0001 1.0 -1.0)
  
  (sphere 0.0 0.0 0.0001 -1.0 0.0)
  (sphere 0.0 0.0 0.0001 -1.0 1.0)
  (sphere 0.0 0.0 0.0001 -1.0 -1.0)
  )

(define slabPoints (list (xy 0.0 0.0)
                         (xy 10.0 0.0)
                         (xy 10.0 10.0)
                         (xy 0.0 10.0)
                         (xy 0.0 0.0)))

(define hole-points (list (xy 2.0 2.0)
                          (xy 8.0 2.0)
                          (xy 8.0 8.0)
                          (xy 2.0 8.0)
                          (xy 2.0 2.0)))

;;Park of trees:
;;(send (park 1324 (xy -10 -10) 10 10 8))
;;other objects id's: 1366 1362
(define (park object-index orig-pos rows columns distance-between-trees)
  (for ([c columns])
       (for ([r rows])
            (object object-index (xy (+ (cx orig-pos) (* r distance-between-trees)) (+ (cy orig-pos)(* c distance-between-trees)))))))

(define (see-object n until step)
  (object n (xy (+ (- until n) step) 0))
  (if (eq? n until)
      (list)
      (see-object (+ n 1) until (+ step 10))))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Examples:
;;
;; (send (write-msg-name "Test"))
;;
;; (send (wall (xy 0.0 0.0) (xy 3.0 0.0) 3.0) (wall (xy 1.0 1.0) (xy 3.0 1.0) 3.0))
;;

;using IDs
;; (send (define wallId (wall (xy 0.0 0.0) (xy 3.0 0.0) 3.0)) (define wallId2 (wall (xy 1.0 1.0) (xy 3.0 1.0) 3.0)))
;; (send (define sphereId (sphere 0.0 0.0 0.0001 0.0 0.0)) (define sphereId2 (sphere 0.0 0.0 0.0001 1.0 1.0)))

;Wall
;; (send (wall (xy 0.0 0.0) (xy 10.0 0.0) 10.0))
;; (send (wall(xy 0.0 0.0) (xy 0.0 10.0) 3.0 0.3 (* 90 DEGRAD)) (wall(xy 0.0 10.0) (xy 0.0 0.0) 3.0 0.3 (* 90 DEGRAD)))

;Doors
;; (send (define wallId (wall (xy 0.0 0.0) (xy 3.0 0.0) 3.0) )(door wallId 1.0 0.0) (define wallId2 (wall (xy 1.0 1.0) (xy 3.0 1.0) 3.0)) (door wallId2 1.0 1.0))
;;= (send (door (wall (xy 0.0 0.0) (xy 3.0 0.0) 3.0) 1.0 0.0) (story-above 10) (door (wall (xy 0.0 0.0) (xy 3.0 0.0) 3.0) 1.0 0.0))

;Window and Door
;; (send (define wallId (wall (xy 0.0 0.0) (xy 5.0 0.0) 3.0)) (window wallId 4.0 0.635) (door wallId 1.0 0.0))

;creating a chapel
;; (send (chapel))

;Shell
;; (send (complex-shell tmat lstpoints lstarcs 1 hpoints harcs hheight htmat 0.0 0.0))
;; (send (simple-shell lstpoints))
;; (send (shell lstpoints lstarcs))
;; (send (rotate-shell "x" 90 (shell lstpoints lstarcs)))
;; (send (let ((shell-id (shell lstpoints lstarcs)))(rotate-shell "x" 90 shell-id)(rotate-shell "y" 90 shell-id)))
;; (send (rotate-shell "y" 90 (rotate-shell "x" 90 (shell lstpoints lstarcs))))
;; (send (translate-shell (list 0 5 0) (shell lstpoints lstarcs)))
;; (send (translate-shell (list 11 11 0) (rotate-shell "x" 90 (shell lstpoints lstarcs))))

;Shell Hole
;; (send (hole-on-slab hpoints harcs hheight (translate-shell (list 11 11 0) (rotate-shell "x" 90 (shell lstpoints lstarcs)))))
;; (send (hole-on-slab hpoints harcs hheight (shell lstpoints lstarcs)))
;; (send (hole-on-slab hpoints harcs hheight (hole-on-slab hpoints harcs hheight (shell lstpoints lstarcs))))
;; (send (rotate-shell "y" 180 (hole-on-slab hpoints harcs hheight (shell lstpoints lstarcs))))
;; (send (hole-on-slab hpoints harcs hheight (rotate-shell "y" 180 (hole-on-slab hpoints harcs hheight (shell lstpoints lstarcs)))))

;Curtain Walls
;; (send (curtain-wall cPoints cArcs 5))
;;= (send (curtain-wall cPoints cArcs 5) (story-above 10) (curtain-wall cPoints cArcs 5))
;; (send (add-arcs (curtain-wall cPoints (list) 5) cArcs))
;; (send (add-arcs (add-arcs (curtain-wall cPoints (list) 5) cArcs) cArcs))

;Translate Curtain Wall
;; (send (translate-element (xyz 0 0 10) (curtain-wall cPoints cArcs 5)))

;Slab
;; (send (slab slabPoints (list) 0.0))
;; (send (rotate-element (slab slabPoints (list) 0.0) "z" (* 45 DEGRAD)))
;; (send (slab cPoints cArcs 0.0))

;Create walls or curtain walls on a regular slab
;; (send (walls-from-slab (slab slabPoints (list) 0.0) 5.0))
;;= (send (walls-from-slab (slab slabPoints (list) 0.0) 5.0) (story-above 5) (walls-from-slab (slab slabPoints (list)) 5.0))
;; (send (cwalls-from-slab (slab slabPoints (list) 0.0) 5.0))

;Create walls or curtain walls on an irregular slab
;; (send (walls-from-slab (slab slabPoints cArcs 0.0) 5.0))
;; (send (cwalls-from-slab (slab slabPoints cArcs 0.0) 5.0))

;Create Slab For Absolute Tower
;; (send (slab ATslab1 (list) 0.0))
;; (send (rotate-element (slab ATslab1 (list) 0.0) "z" (* 90 DEGRAD)))

;Trim Elements
;; (send (trim-elements (wall (xy -5.0 5.0) (xy 15.0 5.0) 3.0) (slab slabPoints (list)) ))

;PolyWall
;;(send (multi-wall (list (xy 0.0 0.0) (xy -10.0 0.0) (xy -10.0 10.0) (xy 0.0 10.0)) (list) 3.0 0.0 1.0))
;;;;create door into polywall
;;;; (send (define laux1 (multi-wall (list (xy 0.0 0.0) (xy -10.0 0.0) (xy -10.0 10.0) (xy 0.0 10.0)) (list) 3.0 0.0 1.0)))
;;;; followed by (send (door (car laux1) 1.0 0.0))

;True PolyWall - Problems with windows and orientation
;;(send (wallTest (list (xy 0.0 0.0) (xy -10.0 0.0) (xy -10.0 10.0) (xy 0.0 10.0)) (list) 3.0 0.0 1.0))
;;(send (wallTest (list (xy 0.0 0.0) (xy 10.0 0.0) (xy 10.0 10.0) (xy 0.0 10.0)) (list) 3.0 0.0 1.0))
;;(send (wallTest (list (xy 10.0 0.0) (xy 0.0 0.0) (xy 0.0 10.0) (xy 10.0 10.0)) (list) 3.0 0.0 1.0))

;Intersect Wall
;; (send (intersect-wall (wall (xy 5.0 0.0) (xy 15.0 0.0) 3.0) (slab slabPoints (list)) ))
;; (send (intersect-wall (wall (xy -5.0 5.0) (xy 15.0 5.0) 3.0) (slab slabPoints (list)) ))
;; (send (intersect-wall (wall (xy 40.0 0.0) (xy 40.0 50.0) 3.0) (slab slabPoints (list)) #t))

;Column
;; (send (column (xyz 0.0 0.0 0.0) 0.0 10.0 true 360 5.0 5.0))

;Story
;; (send (story-below 10.0) (slab slabPoints (list)) (story-below 10.0) (slab slabPoints (list)) (story-below 10.0) (slab slabPoints (list)))
;; (send (story-above 10.0) (story-above 10.0) (define current-story-information (check-story)))
;; (send (story-below 10.0) (story-below 10.0) (define current-story-information (check-story)))
;; (send (story 10) (story 20) (story 10))

;Delete
;; (send (delete-elements (wall (xy -5.0 5.0) (xy 15.0 5.0) 3.0)))
;;= (send (define wallIDAux (wall (xy 0.0 0.0) (xy 3.0 0.0) 3.0)) (door wallIDAux 1.0 0.0) (delete-elements wallIDAux))


;Mixed Tests
;; (send (wall (xy 0.0 0.0) (xy 3.0 0.0) 3.0) (curtain-wall cPoints cArcs 5) (story-above 10) (wall (xy 0.0 0.0) (xy 3.0 0.0) 3.0)(curtain-wall cPoints cArcs 5))



#|
(define (superellipse p a b n t)
  (+xy p (* a (expt (expt (cos t) 2) (/ 1 n)) (sgn (cos t)))
       (* b (expt (expt (sin t) 2) (/ 1 n)) (sgn (sin t)))))

(define (points-superellipse p a b n n-points)
  (map (lambda (t) (superellipse p a b n t))
       (division -pi pi n-points #f)))

(define p (xyz 0 0 0))
(define d 6.3)
(define l-corridor 2.2)
(define t 0.3)
(define r-small 15)
(define daux6 (- 6.3 l-corridor))
(define central-hole (list (+xy p (- (+ daux6 (/ t 2))) (- (+ daux6 (/ t 2))))
                           (+xy p (+ (+ daux6 (/ t 2))) (- (+ daux6 (/ t 2))))
                           (+xy p (+ (+ daux6 (/ t 2))) (+ (+ daux6 (/ t 2))))
                           (+xy p (- (+ daux6 (/ t 2))) (+ (+ daux6 (/ t 2))))
                           (+xy p (- (+ daux6 (/ t 2))) (- (+ daux6 (/ t 2))))))


(define (several-stories number)
  (for ([i number])
    (let* ((slab-points-aux (points-superellipse (xy 0 0) 26 21 1.75 50))
           (slab-points (append slab-points-aux (list (car slab-points-aux))))
           ;(slab-id (slab slab-points (list)))
           ;(slab-id (slab cPoints cArcs))
           (slab-id (slab slabPoints))
           )
      (walls-from-slab slab-id 10)
      ;(hole-slab slab-id central-hole)
      (hole-slab slab-id hole-points)
      ;(rotate-element-z slab-id (* i 10))
      
      (checked-story-above 10))))

(define (test-slab)
  (define slab-id (slab slabPoints))
  (walls-from-slab slab-id 10)
  (hole-slab slab-id hole-points)
  (checked-story-above 10)
  (set! slab-id (slab slabPoints))
  (walls-from-slab slab-id 10)
  (hole-slab slab-id hole-points)
  ;(delete-elements slab-id)
  )
|#

#| DIFFERENT WAY OF DOING slab FUNCTION - USING KEYWORDS
(define slab 
  (lambda (listpoints #:listarcs [listarcs (list)] #:bottomOffset [bottomOffset 0] #:material [material 60] #:thickness [thickness 0.0])
    (let ((slab-msg (slabmessage* #:level bottomOffset
                                  #:material material
                                  #:thickness thickness)))
    (write-msg "Slab" slab-msg)  
    (send-points listpoints)
    (send-arcs listarcs)
    (elementid-guid (read-sized (cut deserialize (elementid*) <>)input)))))
|#
