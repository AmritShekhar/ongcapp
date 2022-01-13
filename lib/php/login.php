<?php 
    error_reporting(E_ERROR);
    include "connection.php";
    include "crypto.php";
    
    $email = decrypt($_POST['email']);
    $pass = sha1(decrypt($_POST['pass']));

    try {
        if(isset($email, $pass)) {
            $req = $db->prepare("SELECT * FROM users WHERE email=? AND password=?");
            $req->execute(array($email, $pass));
            $exist = $req->rowCount();
            if($exist == 1) {
                $array = $req->fetch();
                $msg = "Successfully logged in";
                $success = 1;
            } else {
                $msg = "Email or password is incorrect";
                $success = 0;
            }
        } else {
            $success = 0;
            $msg = "Error: Empty data";
        }
    } catch (\Throwable $th) {
        $success = 0;
        $msg = "Error: ".$th->getMessage();
    }

    echo encrypt(
        json_encode([
            "data"=>[
                $msg,
                $success,
                $array
            ]
        ])
    );

?>