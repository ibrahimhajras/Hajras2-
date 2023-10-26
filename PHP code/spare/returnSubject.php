<?php
include "../contact.php";

$subject_ids = filterrerquest("subject_ids");
$subject_ids = explode(',', $subject_ids);

$placeholders = implode(',', array_fill(0, count($subject_ids), '?'));

$stat = $con->prepare("SELECT `subject` FROM `subject` WHERE `subject_id` IN ($placeholders)");

$stat->execute($subject_ids);

$data = $stat->fetchAll(PDO::FETCH_ASSOC);

if ($data) {
    echo json_encode(array("status" => "s",  "data" => $data));
} else {
    echo json_encode(array("status" => "f"));
}

?>
