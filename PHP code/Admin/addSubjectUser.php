<?php
include "../contact.php"; 

$user_id = filterrerquest("user_id"); 
$subject_id = filterrerquest("subject_id");

try {
    $stat = $con->prepare("INSERT INTO `user_subjects`(`user_id`, `subject_id`) VALUES (?,?)");
    $stat->execute(array($user_id, $subject_id));
    $count = $stat->rowCount();

    if ($count > 0) {
        echo json_encode(array("status" => "s"));
    }
} catch (PDOException $e) {
    echo json_encode(array("status" => "f", "message" => "Error: " . $e->getMessage()));
}
?>
