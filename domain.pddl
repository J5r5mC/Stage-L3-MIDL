(define (domain meeting)
  (:requirements :strips :typing :durative-actions :numeric-fluents)
  (:types 
    agent - object
    employee - agent
    room - object
    room - object)

  (:predicates
    (at ?e - employee ?r - room)
    (in-meeting-room ?e - employee ?m - meeting)
    (p1-ready ?m - meeting) ;; 1ère personne arrivée
    (p2-ready ?m - meeting) ;; 2ème personne arrivée
    (all-ready ?m - meeting) ;; Tout le monde est là
    (not-yet-holds ?m - meeting)
    (already-holds ?m - meeting)
    (different-empl ?e1 ?e2 - employee)
  )

  (:functions
    (distance ?r1 ?r2 - room)
  )

  ;; L'action de déplacement
  (:durative-action travel-and-enter
    :parameters (?e - employee ?r_from - room ?r_to - room ?m - meeting)
    :duration (= ?duration (distance ?r_from ?r_to))
    :condition (at start (at ?e ?r_from))
    :effect (and
      (at start (not (at ?e ?r_from)))
      (at end (at ?e ?r_to))
      (at end (in-meeting-room ?e ?m))
    )
  )

  ;; --- LOGIQUE D'ACCUMULATION (Ordre libre) ---

  ;; Étape 1 : N'importe qui peut être le premier
  (:durative-action validate-first
    :parameters (?e - employee ?m - meeting)
    :duration (= ?duration 0.1)
    :condition (at start (in-meeting-room ?e ?m))
    :effect (and
      (at end (not (in-meeting-room ?e ?m)))
      (at end (p1-ready ?m))
    )
  )

  ;; Étape 2 : Une fois le 1er validé, un autre devient le 2ème
  (:durative-action validate-second
    :parameters (?e - employee ?m - meeting)
    :duration (= ?duration 0.1)
    :condition (and (at start (p1-ready ?m)) (at start (in-meeting-room ?e ?m)))
    :effect (and
      (at end (not (in-meeting-room ?e ?m)))
      (at end (p2-ready ?m))
    )
  )

  ;; Étape 3 : Le dernier valide la présence totale
  (:durative-action validate-third
    :parameters (?e - employee ?m - meeting)
    :duration (= ?duration 0.1)
    :condition (and (at start (p2-ready ?m)) (at start (in-meeting-room ?e ?m)))
    :effect (and
      (at end (not (in-meeting-room ?e ?m)))
      (at end (all-ready ?m))
    )
  )

  (:durative-action hold-meeting_3
    :parameters (?e1 - employee ?e2 - employee ?e3 - employee ?m - meeting)
    :duration (= ?duration 5)
    :condition (and 
      (at start (all-ready ?m)) 
      (at start (not-yet-holds ?m))
      (at start (different-empl ?e1 ?e2))
      (at start (different-empl ?e1 ?e3))
      (at start (different-empl ?e2 ?e3)))
    :effect (and 
      (at end (not (not-yet-holds ?m)))
      (at end (already-holds ?m)))
  )
)