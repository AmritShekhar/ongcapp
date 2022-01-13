<?php  

    include "connection.php";
    include "crypto.php";

    $post = json_decode(decrypt($_POST["data"]));
    $id_user = $post->id_user;
    $title = $post->title;
    $basin = $post->basin;
    $description = $post->description;
    $isok = false;
    $msg = "";

    try {
        $req = $db->prepare("INSERT INTO posts(id_user, title, basin, description) VALUES(?,?,?,?)");
        $req->execute(array($id_user, $title, $basin, $description));
        if($req) {
            $isok = true;
            $msg = "Posted successfully";
        } else {
            $msg = "Something went wrong";
        }
    } catch (\Throwable $th) {
        $msg = "Something went wrong";
    }

    echo encrypt(json_encode([
        $isok,
        $msg
    ]))

?>