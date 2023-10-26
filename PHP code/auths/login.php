
<?php
include "../contact.php";

$email = filterrerquest("email");
$password = filterrerquest("password");


$stat = $con->prepare("SELECT `id` ,`email`, `password` ,`admin` FROM `users` WHERE `email` = ? AND `password` = ?");
$stat->execute(array($email,$password));

$data = $stat->fetch(PDO::FETCH_ASSOC);


$count =$stat->rowCount();

if($count>0)echo  json_encode(array("status"=>"s" , "data" => $data));
else echo  json_encode(array("status"=>"f"));


?>
