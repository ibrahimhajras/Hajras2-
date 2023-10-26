<?php
include "../contact.php";

$username = filterrerquest("username");


$stat = $con->prepare("SELECT `id` FROM `users` WHERE `username`= ? ");


$stat->execute(array($username));


$data = $stat->fetch(PDO::FETCH_ASSOC);


$count = $stat->rowCount();


if ($count > 0) {
    echo json_encode(array("status" => "s",  "data" => $data));
} else {
    echo json_encode(array("status" => "f"));
}
?>
