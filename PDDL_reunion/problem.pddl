(define (problem meeting-prob)
  (:domain meeting)
  (:objects
    alice bob carol - employee
    officeA officeB officeC conf-room - room
    conf1 - meeting
  )

  (:init
    ;; Positions initiales éparpillées
    (at alice officeA)
    (at bob officeB)
    (at carol officeC)

    ;;Tous les employés sont différents
    (different-empl alice bob)
    (different-empl carol bob)
    (different-empl alice carol)

    ;; Distances vers la salle de réunion
    (= (distance officeA conf-room) 10) ;; Alice est loin
    (= (distance officeB conf-room) 2)  ;; Bob est tout près
    (= (distance officeC conf-room) 5)  ;; Carol est au milieu

    ;; On peut aussi définir la distance retour si besoin
    (= (distance conf-room officeA) 10)

    ;; la réunion n'a pas encore commencé
    (not-yet-holds conf1)

  )

  (:goal (already-holds conf1))
)