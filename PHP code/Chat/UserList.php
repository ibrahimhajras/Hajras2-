<?php
include "../contact.php";

$id = filterrerquest("id");

$stmt = $con->prepare("SELECT u.id, u.username
FROM users u
WHERE u.id != ?
AND EXISTS (
    SELECT 1
    FROM user_subjects us1
    WHERE us1.user_id = ?
    AND EXISTS (
        SELECT 1
        FROM user_subjects us2
        WHERE us2.user_id = u.id
        AND us2.subject_id = us1.subject_id
    )
)");
$stmt->execute([$id, $id]); // Use an array to pass parameters to execute
$count = $stmt->rowCount();
if ($count > 0) {
    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
    echo json_encode(array("status" => "s", "data" => $rows));
} else {
    echo json_encode(array("status" => "f"));
}
?>
