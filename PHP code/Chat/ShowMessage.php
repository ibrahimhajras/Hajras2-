
<?php
include "../contact.php";

$sender = filterrerquest("sender");
$receiver = filterrerquest("receiver");


$stat = $con->prepare("SELECT chat.*, users.username FROM chat
LEFT JOIN users ON chat.sender = users.id
WHERE chat.sender = ? OR chat.receiver = ?");
$stat->execute(array($sender, $sender));

$count = $stat->rowCount();
if ($count > 0) {
  $rows = $stat->fetchAll(PDO::FETCH_ASSOC);
  echo json_encode(array("status" => "s", "data" => $rows));
} else {
  echo json_encode(array("status" => "f"));
}
?>
