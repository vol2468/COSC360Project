<!DOCTYPE html>

<?php
session_start();

if (isset($_SESSION["uid"])) {
    $uid = $_SESSION["uid"];
}

?>

<html>

<head lang="en">
    <meta charset="utf-8">
    <title>Popular Products</title>
    <link rel="stylesheet" href="../css/reset.css" />
    <link rel="stylesheet" href="../css/pop-drop.css" />
    <link href='https://fonts.googleapis.com/css?family=Alata' rel='stylesheet'>
    <link href='https://fonts.googleapis.com/css?family=DM Sans' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
</head>

<body>
    <header>
        <?php
        include_once ("header.php");
        ?>
    </header>

    <main>
        <?php
        include ("breadcrumb.php");
        ?>
        <h1>Popular Products</h1>
        <?php

            // using try catch statement to handle any error
            try {
                // database connection
                include "connect.php";

                if ($error != null) {
                    $output = "<p>Unable to connect to database!</p>";
                    exit($output);
                } else {
                    // MODIFY HERE TO RETRIEVE POPULAR PRODUCT DATA
                    $sql = "SELECT * FROM user WHERE uid = ?";
                    if ($statement = mysqli_prepare($connection, $sql)) {
                        mysqli_stmt_bind_param($statement, "i", $uid);
                        mysqli_stmt_execute($statement);
                        mysqli_stmt_store_result($statement);

                        if (mysqli_stmt_num_rows($statement) < 1) {
                            echo "<p>Invalid uid<p>";
                        } else {
                            // fetch and display the result
                            mysqli_stmt_bind_result($statement, $uid, $uname, $email, $passwd, $imgid, $usertype);

                            mysqli_stmt_fetch($statement);

                        }

                    } else {
                        echo "Failed to prepare statement";
                    }

                    // close the statement and connection
                    mysqli_stmt_close($statement);
                    mysqli_close($connection);
                }

            } catch (Exception $e) {
                echo 'Error Message: ' . $e->getMessage();
            }

            $_SESSION['popularItemNum'] = 8;
            include 'popular_item.php';

        ?>
        <div id="products">
            <!-- 4 cards / row -->
            <?php
                $columnCounter = 0;
                $rowMaxItems = 4; 

                // printout popular item cards
                for ($i=0; $i < count($popularItems); $i++) { 
                    // if($columnCounter%$rowMaxItems == 0){
                    //     // Open new row
                    //     echo '<div class="row">';
                    // }
                    echo '<div class="card">';
                    echo '<a href="product.php?pid='.$priceDropItems[$i].'"><img src="data:image/jpg;base64,'.base64_encode($popularItemImages[$i]).'" style="width: 100%;"/></a>';
                    echo '<h3>'.$popularItemNames[$i].'</h3>';
                    echo '<p class="price">$'.$popularItemPrices[$i].'</p>';
                    echo '<p><button><a href="product.php?pid='.$popularItems[$i].'">See Product Detail</a></button></p>';
                    echo '</div>';
                    // if($columnCounter%$rowMaxItems == $rowMaxItems-1){
                    //     // Open new row
                    //     echo '</div>';
                    // }
                    // $columnCounter++;
                }
            ?>
        </div>

    </main>

    <footer>
        <?php
        include_once ("footer.php");
        ?>
    </footer>

</body>

</html>