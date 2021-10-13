<?php
    $shell = "/home/script/update.sh";
    echo "Starting Update!<br>";
    if (isset($_GET["debug"])&&$_GET["debug"]=="true") {
        echo "Debug mode!";
        system($shell);
    } else {
        exec($shell, $result, $status);
        if ($status) {
            echo "An error occur!({$status})<br>{$result}<br>";
        } else {
            echo "Success!<br>";
        }
    }

?>