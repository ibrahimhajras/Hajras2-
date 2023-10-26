<?php
include "../contact.php";

$user_id = filterrerquest("user_id"); 
$subject_id = filterrerquest("subject_id");
$mark = filterrerquest("mark");

$stat = $con->prepare("UPDATE `user_subjects` SET `mark` = ? WHERE `user_id` = ? AND `subject_id` = ?");
$stat->execute(array($mark, $user_id, $subject_id));

$count = $stat->rowCount();

if ($count > 0) {
    echo json_encode(array("status" => "s"));
} else {
    echo json_encode(array("status" => "f"));
}
?>
