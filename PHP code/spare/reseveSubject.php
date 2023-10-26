<?php
include "../contact.php";

$user_id = filterrerquest("user_id");

$stmt_user_subjects = $con->prepare("SELECT us.user_id, us.subject_id, us.mark, s.subject 
FROM user_subjects us
JOIN subject s ON us.subject_id = s.subject_id
WHERE us.user_id = ?");
$stmt_user_subjects->execute([$user_id]);
$user_subjects = $stmt_user_subjects->fetchAll(PDO::FETCH_ASSOC);

if (!empty($user_subjects)) {
    echo json_encode($user_subjects);
} else {
    echo json_encode(array("message" => "No subjects found for the user."));
}
?>
