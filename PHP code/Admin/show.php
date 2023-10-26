
<?php
include "../contact.php";



$stat = $con->prepare("SELECT * FROM `users` where admin = 0");
$stat->execute();

$data = $stat->fetchAll(PDO::FETCH_ASSOC);


echo  json_encode(array("data" => $data));


?>
