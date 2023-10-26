
<?php
include "../contact.php";



$stat = $con->prepare("SELECT * FROM `Subject` ");
$stat->execute();

$data = $stat->fetchAll(PDO::FETCH_ASSOC);


echo  json_encode(array("data" => $data));


?>
