<?php
include "../contact.php"; 

$user_id = filterrerquest("user_id"); 


$stat = $con->prepare("SELECT `subject_id` FROM `user_subjects` WHERE `user_id` = ?");
$stat->execute([$user_id]);

$count = $stat->rowCount();
$result = $stat->fetchAll(PDO::FETCH_ASSOC);

if ($count > 0) {
    echo json_encode($result);
} else {
    echo json_encode(array("status" => "f"));
}
?>
