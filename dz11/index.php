<!DOCTYPE HTML>
<html lang="en">
<head>
    <title>Final project Slipez</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/style.css" rel="stylesheet">
</head>

<body>
<h1>Задача Банкомат</h1>

<!-- 500, 200, 100, 50, 20, 10 и 5-->
<form method="post" action="handler.php">
    <label id="number">
        500:
        <input type="text" name="banknote500" value="0">
        <br>200:
        <input type="text" name="banknote200" value="0">
        <br>100:
        <input type="text" name="banknote100" value="0">
        <br>50:
        <input type="text" name="banknote50" value="0">
        <br>20:
        <input type="text" name="banknote20" value="0">
        <br>10:
        <input type="text" name="banknote10" value="0">
        <br> 5:
        <input type="text" name="banknote5" value="0">
        <br>
<!--        <input type="text" name="number" value="введите число">-->
        <br>
        <input type="submit" value="Дай денег">
    </label>
</form>
<!--<br>-->
<?php
if (file_exists("data.json")) {
    $handle = fopen('data.json', 'rb');
    $str = fread($handle, filesize('data.json'));
    fclose($handle);
    $data = json_decode($str, true);
}
echo "<h3>Наявність:</h3>";
include "table.php";
printTable($data);

//echo 2 + 2;
//$var = 5;
//$var = 'string';
//echo $var;

?>

</body>
</html>

<!--
В банкомате имеется определенный запас купюр номиналом 500, 200, 100, 50, 20, 10 и 5 грн.
Если всех купюр по 10 - то сумма = 8850
Задача: написать программу, которой с помощью формы передается желаемая сумма в гривнах (целое число), и которая рассчитывает (если это возможно), сколько купюр какого номинала надо выдать. Выдать деньги надо как можно меньшим числом купюр.

Если выдать требуемую сумму невозможно (сумма не кратна 5, в банкомате недостаточно купюр, сумма меньше 5), должна отобразиться страница с сообщением:

Выдача невозможна: (причина).

Если выдать требуемую сумму возможно, программа должна вывести результат в таком формате:

Сумма: (сумма числом)
Число купюр: 10x500 2x200 3x10

На странице результата должна быть ссылка для возврата на страницу с формой.
Верстка страниц с формой и результатом - по желанию.
-->
