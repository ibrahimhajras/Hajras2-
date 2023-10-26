
<?php
include "../contact.php";

$sender = filterrerquest("sender");
$receiver = filterrerquest("receiver");
$textmessage = filterrerquest("textmessage");


$stat = $con->prepare("INSERT INTO `chat`(`sender`, `receiver`, `textmessage`) VALUES (?,?,?)");
$stat->execute(array($sender,$receiver,$textmessage));
$count =$stat->rowCount();
if($count>0)echo  json_encode(array("status"=>"s"));
else echo  json_encode(array("status"=>"f"));


?>