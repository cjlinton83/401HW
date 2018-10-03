<html>
    <head>
    </head>
    <body>
        <?php
            $score = getScore();

            print "User: ".$_POST['firstName']." ".$_POST['lastName']."\n";
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