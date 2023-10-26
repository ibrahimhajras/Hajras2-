<?php

function filterrerquest($Rname){

return htmlspecialchars(strip_tags($_POST[$Rname]));

}

?>