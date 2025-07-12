;Header and description

(define (domain robot_waiter)

    ;remove requirements that are not needed
    (:requirements :strips :fluents :conditional-effects :negative-preconditions :equality)

    ; un-comment following line if constants are needed
    ;(:constants )

    (:predicates ;todo: define predicates here
        (Adjacent ?a1 ?a2)
        (At ?who ?where)
        (Holding ?robot ?plate)
        (FreeHands ?robot)
        (HasFood ?plate)
        (Served ?client)
        (IsBTA ?a)
        (IsRobot ?robot)
        (IsClient ?client)
    )

    (:functions ;todo: define numeric functions here
    )

    (:action Move
        :parameters (?robot ?a1 ?a2)
        :precondition (and (Adjacent ?a1 ?a2) (At ?robot ?a1)(IsRobot ?robot))
        :effect (and (At ?robot ?a2) (not(At ?robot ?a1)))
    )
    (:action Present
        :parameters (?robot ?client ?where ?plate)
        :precondition (and (not(Served ?client))(IsClient ?client) (At ?robot ?where)(At ?client ?where) (HasFood ?plate)(Holding ?robot ?plate))
        :effect (and (Served ?client) (not(Holding ?robot ?plate)) (At ?plate ?where) (FreeHands ?robot))
    )

    (:action Pickup
        :parameters (?robot ?BTA ?plate)
        :precondition (and (not(Holding ?robot ?plate)) (At ?robot ?BTA)(FreeHands ?robot) (At ?plate ?BTA))
        :effect (and (Holding ?robot ?plate) (not(FreeHands ?robot)) (not(At ?plate ?BTA)))
    )

    (:action Fill
        :parameters (?robot ?BTA ?plate)
        :precondition (and (At ?robot ?BTA) (At ?plate ?BTA)
            (not(HasFood ?plate)) (IsBTA ?BTA))
        :effect (and (HasFood ?plate))
    )

    ;define actions here

)