
<?php
include "../contact.php";

$subject = filterrerquest("subject");
$mark = filterrerquest("mark");




$stat = $con->prepare("INSERT INTO `Subject`(`subject`, `mark`) VALUES (?,?)");
$stat->execute(array($subject,$mark));
$count =$stat->rowCount();

if($count>0)echo  json_encode(array("status"=>"s"));
else echo  json_encode(array("status"=>"f"));


?>
