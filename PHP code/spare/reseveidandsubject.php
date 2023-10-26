<?php
include "../contact.php";

$username = filterrerquest("username");
$subject = filterrerquest("subject");

$stat = $con->prepare("SELECT `id` FROM `users` WHERE `username`= ? ");
$stat1 = $con->prepare("SELECT `subject_id` FROM `subject` WHERE `subject` = ? ");

$stat->execute(array($username));
$stat1->execute(array($subject));

$data = $stat->fetch(PDO::FETCH_ASSOC);
$data1 = $stat1->fetch(PDO::FETCH_ASSOC);

$count = $stat->rowCount();
$count1 = $stat1->rowCount();

if ($count > 0 && $count1 > 0) {
    $id = $data['id'];
    $subject_id = $data1['subject_id'];
    echo json_encode(array("status" => "s", "id" => $id, "subject_id" => $subject_id));
} else {
    echo json_encode(array("status" => "f"));
}
?>
