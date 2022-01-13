<?php 
    error_reporting(E_ERROR);
    include "connection.php";
    
    $name = $_POST['name'];
    $email = $_POST['email'];
    $pass = sha1($_POST['pass']);

    try {
        if(isset($name, $email, $pass)) {
            $req = $db->prepare("SELECT * FROM users WHERE email=?");
            $req->execute(array($email));
            $exist = $req->rowCount();
            if($exist == 0) {
                $req = $db->prepare("INSERT INTO users VALUES(null,?,?,?)");
                $req->execute(array($name, $email, $pass));
                if($req) {
                    $success = 1;
                    $msg = "Everything went great";
                } else {
                    $success = 0;
                    $msg = "Something went wrong";
                }
            } else {
                $msg = "Email already exists!";
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

    echo json_encode([
        "data"=>[
            $msg,
            $success
        ]
        ]);

?>