<?php
include "../contact.php";


$username = filterrerquest("username");
$email = filterrerquest("email");
$id = filterrerquest("id");


$stat = $con->prepare("UPDATE `users` SET `username`= ? ,`email`= ?  WHERE `id` = ?");
$stat->execute(array($username, $email, $id));


$count =$stat->rowCount();

if($count>0)echo  json_encode(array("status"=>"s"));
else echo  json_encode(array("status"=>"f"));


?>
