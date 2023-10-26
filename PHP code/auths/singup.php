
<?php
include "../contact.php";

$username = filterrerquest("username");
$email = filterrerquest("email");
$password = filterrerquest("password");



$stat = $con->prepare("INSERT INTO `users`(`username`, `email`, `password`) VALUES (?,?,?)");
$stat->execute(array($username,$email,$password));
$count =$stat->rowCount();

if($count>0)echo  json_encode(array("status"=>"s"));
else echo  json_encode(array("status"=>"f"));


?>
