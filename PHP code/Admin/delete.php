
<?php
include "../contact.php";

$id = filterrerquest("id");



$stat = $con->prepare("DELETE FROM `users` WHERE `id` = ?");
$stat->execute(array($id));

$count =$stat->rowCount();

if($count>0)echo  json_encode(array("status"=>"s"));
else echo  json_encode(array("status"=>"f"));


?>
