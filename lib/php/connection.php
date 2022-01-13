<?php
    $host = "localhost";
    $dbname = "ongcdb";
    $user = "root";
    $pass = "forlorn4Horses";
    try {
        $db = new PDO("mysql:host=$host; dbname=$dbname", $user, $pass);
        // echo "connected";
    } catch (\Throwable $th) {
        // echo "Error: ".$th->getMessage();
    }
?>