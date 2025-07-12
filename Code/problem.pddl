(define (problem problem_robotwaiter)
    (:domain robot_waiter)
    (:objects
        robot1 robot2 ;robots
        plate1 plate2 plate3;plates
        BTA PUA AUA PMA AMA PLA ALA ;rooms
        client1 client2 client3;clients
        )

    (:init
        ;todo: put the initial state's facts and numeric values here

        ;BTA
        (IsBTA BTA)
        (not(IsBTA PUA))
        (not(IsBTA AUA))
        (not(IsBTA PMA))
        (not(IsBTA AMA))
        (not(IsBTA PLA))
        (not(IsBTA ALA))

        ;room adjacent
        (Adjacent BTA AUA)
        (Adjacent AUA BTA)
        (Adjacent AUA PUA)
        (Adjacent PUA AUA)
        (Adjacent AUA AMA)
        (Adjacent AMA AUA)
        (Adjacent PUA PMA)
        (Adjacent PMA PUA)
        (Adjacent AMA ALA)
        (Adjacent ALA AMA)
        (Adjacent PMA PLA)
        (Adjacent PLA PMA)
        (Adjacent PLA ALA)
        (Adjacent ALA PLA)

        ;initial state of the robot
        (IsRobot robot1)
        (At robot1 BTA)
        (FreeHands robot1)
        (not(Holding robot1 plate1))
        (not(Holding client1 plate1))

        (IsRobot robot2)
        (At robot2 AUA)
        (FreeHands robot2)
        (not(Holding robot2 plate3))
        (not(Holding client3 plate3))

        ;initial state of the plate
        (At plate1 BTA)
        (At plate2 BTA)
        (At plate3 BTA)
        (not(HasFood plate1))
        (not(HasFood plate2))
        (not(HasFood plate3))

        ;initial state of the client
        (IsClient client1)
        (At client1 PMA)

        (IsClient client2)
        (At client2 ALA)

        (IsClient client3)
        (At client3 PLA)
        ;(not(Served client1))

    )

    (:goal
        (and
            ;todo: put the goal condition here

            ;final state of the robot 
            (At robot1 BTA)
            (FreeHands robot1)
            (not(Holding robot1 plate1))

            (At robot2 BTA)
            (FreeHands robot2)
            (not(Holding robot2 plate3))

            ;final state of the plate
            (At plate1 PMA)
            (At plate2 ALA)
            (At plate3 PLA)
            (HasFood plate1)
            (HasFood plate2)
            (HasFood plate3)

            ;final state of the client 
            (Served client1)
            (Served client2)
            (Served client3)
        )
    )

    ;un-comment the following line if metric is needed
    ;(:metric minimize (???))
)