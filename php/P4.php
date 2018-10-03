<html>
    <head>
    </head>
    <body>
        <?php
            print "Welcome ".$_POST['firstName']."<br>";
            foreach ($_POST as $e => $f)
                print("POST[".$e."] = ".$f);
        ?>
    </body>
</html>