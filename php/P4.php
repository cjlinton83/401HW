<html>
    <head>
    </head>
    <body>
        <?php
            $firstName = $_POST['firstName'];
            $lastName = $_POST['lastName'];
            $score = getScore();
            $grade = getGrade($score);
            
            print "User: ".$firstName." ".$lastName."<br>";
            print "Score: ".$score."<br>";
            print "Grade: ".$grade."<br>";

            function getScore() {
                $score = 0;

                if ($_POST['q1'] == 'a')
                    $score++;
                if ($_POST['q2'] == 'c')
                    $score++;
                if ($_POST['q3'] == 'a')
                    $score++;
                if ($_POST['q4'] == 'a')
                    $score++;
                if ($_POST['q5'] == 'c')
                    $score++;
                if ($_POST['q6'] == 'b')
                    $score++;
                if ($_POST['q7'] == 'a')
                    $score++;
                if ($_POST['q8'] == 'c')
                    $score++;
                if ($_POST['q9'] == 'a')
                    $score++;
                if ($_POST['q10'] == 'P4.php')
                    $score++;
                
                $score *= 10;
                return $score;
            }

            function getGrade($score) {
                $grade = '';

                if (($score <= 100) && (score >= 90)) {
                    $grade = 'A';
                } elseif (($score < 90) && (score >= 80)) {
                    $grade = 'B';
                } elseif (($score < 80) && (score >= 70)) {
                    $grade = 'C';
                } elseif (($score < 70) && (score >= 60)) {
                    $grade = 'D';
                } else {
                    $grade = 'F';
                }

                return $grade;
            }
        ?>
    </body>
</html>