<?php
// Database connection setup
include_once ("db_config.php");

// Get product ID
// $pid = $_POST['pid'];
$pid = 1;

// Prepare and execute SQL query
$sql = "SELECT review.comment, review.rate, CAST(review.DATE AS DATE) AS date_only, user.uname FROM review 
        JOIN user ON review.uid = user.uid 
        WHERE review.pid = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $pid);
$stmt->execute();
$result = $stmt->get_result();

// Handle potential errors
if (!$result) {
    http_response_code(500);
    echo "Failed to fetch reviews";
    exit;
}

// Format reviews as HTML 
$reviewsHtml = "";
while ($row = $result->fetch_assoc()) {
    $reviewsHtml .= "<div class='review'>";
    $reviewsHtml .= "<div class='star'>";
    for ($i = 0; $i < $row['rate']; $i++) {
        $reviewsHtml .= "★";  // Filled star
    }
    for ($i = 0; $i < (5 - $row['rate']); $i++) {
        $reviewsHtml .= "☆";  // Empty star 
    }
    $reviewsHtml .= "</div>";
    $reviewsHtml .= "<p><strong>" . $row['uname'] . "</strong></p>";
    $reviewsHtml .= "<p>" . $row['comment'] . "</p>";
    $reviewsHtml .= "<p><small>Posted on " . $row['date_only'] . "</small></p>";
    $reviewsHtml .= "</div>";
}

// Output the HTML
echo $reviewsHtml;

// Close resources
$stmt->close();
$conn->close();

