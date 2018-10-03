<html>
    <head>
    </head>
    <body>
        <?php
            $firstName = $_POST['firstName'];
            $lastName = $_POST['lastName'];
            $score = getScore();
            
            print "User: ".firstName." ".lastName."\n";
            print "Score: ".score."\n";

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
        ?>
    </body>
</html>