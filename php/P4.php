<html>
    <head>
    </head>
    <body>
        <?php
            $name = $_POST["lastName"].", ".$_POST["firstName"];
            $score = getScore();
            $grade = getGrade($score);
            
            // Display results from P4.html
            print "User: ".$name."<br>";
            print "Score: ".$score."<br>";
            print "Grade: ".$grade."<br>";

            // Connect to MySQL database
            $connection = new mysqli("localhost", "cmps401", "Mycmps401db", "cmps401");
            if ($connection->connect_error)
                die("<br>Connection failed: ".$connection->connect_error);
            else
                print "<br>Connection successful: database cmps401 connected";
                        
            // Create table to store results from P4.html
            $query = "CREATE TABLE g101 (
                        Name varchar(20),
                        Score     int,
                        Grade     varchar(1),
                        Date      varchar(20),
                        PRIMARY KEY (Name)
            )";
            sendQuery($connection, $query);

            // Query key: if has key, then update record; else, create record.
            $date = date("m/d/Y h:i A");
            if (hasKey($connection, $name)) {
                $q = "UPDATE g101 SET Score='$score', Grade='$grade', Date='$date' WHERE Name='$name'";
                sendQuery($connection, $q);
            } else {
                $q = "INSERT INTO g101 VALUES('$name', '$score', '$grade', '$date')";
                sendQuery($connection, $q);
            }
                

            // Close connection to database
            mysqli_close($connection);

            function getScore() {
                $score = 0;

                if ($_POST["q1"] == "a")
                    $score++;
                if ($_POST["q2"] == "c")
                    $score++;
                if ($_POST["q3"] == "a")
                    $score++;
                if ($_POST["q4"] == "a")
                    $score++;
                if ($_POST["q5"] == "c")
                    $score++;
                if ($_POST["q6"] == "b")
                    $score++;
                if ($_POST["q7"] == "a")
                    $score++;
                if ($_POST["q8"] == "c")
                    $score++;
                if ($_POST["q9"] == "a")
                    $score++;
                if ($_POST["q10"] == "P4.php")
                    $score++;
                
                $score *= 10;
                return $score;
            }

            function getGrade($score) {
                $grade = "";

                if (($score <= 100) && ($score >= 90)) {
                    $grade = "A";
                } elseif (($score < 90) && ($score >= 80)) {
                    $grade = "B";
                } elseif (($score < 80) && ($score >= 70)) {
                    $grade = "C";
                } elseif (($score < 70) && ($score >= 60)) {
                    $grade = "D";
                } else {
                    $grade = "F";
                }

                return $grade;
            }

            function sendQuery($conn, $q) {
                if ($r = mysqli_query($conn, $q))
                    print "<br>Successful Query: ".$q;
                else
                    print "<br>Failed Query: ".$q;
                return $r;
            }

            function hasKey($conn, $name) {
                $q = "SELECT * FROM g101";
                $r = sendQuery($conn, $q);

                for ($i = 0; $row = mysqli_fetch_assoc($r); $i++) {
                    if ($row["Name"] == $name)
                        return true;
                }

                return false;
            }
        ?>
    </body>
</html>