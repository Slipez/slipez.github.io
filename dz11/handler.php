<!DOCTYPE HTML>
<html lang="en">
<head>
    <title>Final project Slipez</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="css/style.css" rel="stylesheet">
</head>

<?php
//
//$a=Array(10, 50, 100, 500, 1000); // какие виды банкнот есть
//$k=count($a); // кол-во видов банкнот
//$n=$_POST['text']; // сумма которую надо выдать
//
//// 1 часть алгоритма
//$INF=PHP_INT_MAX; // const int INF=1000000000; // Значение константы }бесконечность}
//$F=Array(); // int F[n+1];
//$F[0]=0; // F[0]=0;
//// int m, i;
//for($m=1; $m<=$n; ++$m) { // for(m=1; m<=n; ++m) // заполняем массив F
//    // m - сумма, которую нужно выдать
//    $F[$m]=$INF; // F[m]=INF; // помечаем, что сумму m выдать нельзя
//    for($i=0; $i<$k; ++$i){ //for(i=0; i<k; ++i) // перебираем все номиналы банкнот
//        if($m>=$a[$i] && $F[$m-$a[$i]]+1<$F[$m]) { // if(m>=a[i] && F[m-a[i]]+1<F[m])
//            $F[$m] = $F[$m-$a[$i]]+1; // изменяем значение F[m], если нашли
//        }
//    }
//}
//
//// 2 часть алгоритма
//if($F[$n]==$INF) { // if (F[n]==INF)
//    echo "Требуемую сумму выдать невозможно\r\n"; // cout<<"Требуемую сумму выдать невозможно"<<endl;
//}
//else {
//    while($n>0) { // while(n>0)
//        for($i=0;$i<$k;++$i) { // for(i=0;i<k;++i)
//            if ($F[$n-$a[$i]]==$F[$n]-1) { // if (F[n-a[i]]==F[n]-1)
//                echo $a[$i]." "; // cout<<a[i]<<" ";
//                $n-=$a[$i]; // n-=a[i];
//                break;
//            }
//        }
//    }
//}

////$_GET;
//if (iset($_POST['text']) && $_POST['text']) {
// $text = $_POST['text'];
//}
//
////$text2 = $_POST['text2'] ? $_POST['text2'] : 0;
//$text2 = $_POST['text2'] ?: 0;
//
//$text = $_POST['text'];
//$text2 = $_POST['text2'];
//
//echo $text + $text2;
//echo "result";

if (file_exists("data.json")) {
    $handle = fopen('data.json',  'rb'); //открыли файл
    $str = fread($handle, filesize('data.json'));
    fclose($handle);   //закрыли файл
    $data = json_decode($str, true);
}
else {
    $data = ['500' => 10,
        '200' => 10,
        '100' => 10,
        '50' => 10,
        '20' => 10,
        '10' => 10,
        '5' => 10];
}
//var_dump($data);

$banknote500 = $_POST["banknote500"] ? $_POST["banknote500"] : 0;
$banknote200 = $_POST["banknote200"] ? $_POST["banknote200"] : 0;
$banknote100 = $_POST["banknote100"] ? $_POST["banknote100"] : 0;
$banknote50 = $_POST["banknote50"] ? $_POST["banknote50"] : 0;
$banknote20 = $_POST["banknote20"] ? $_POST["banknote20"] : 0;
$banknote10 = $_POST["banknote10"] ? $_POST["banknote10"] : 0;
$banknote5 = $_POST["banknote5"] ? $_POST["banknote5"] : 0;

$err = '';
if (filter_var($banknote500, FILTER_VALIDATE_INT) == false && $banknote500 !='0') {
    $err = $err . "Введіть правильне значення для купюр по 500 грн<br>";
}
if (filter_var($banknote200, FILTER_VALIDATE_INT) == false && $banknote200 !='0') {
    $err = $err . "Введіть правильне значення для купюр по 200 грн<br>";

}if (filter_var($banknote100, FILTER_VALIDATE_INT) == false && $banknote100 !='0') {
    $err = $err . "Введіть правильне значення для купюр по 100 грн<br>";
}
if (filter_var($banknote50, FILTER_VALIDATE_INT) == false && $banknote50 !='0') {
    $err = $err . "Введіть правильне значення для купюр по 50 грн<br>";
}
if (filter_var($banknote20, FILTER_VALIDATE_INT) == false && $banknote20 !='0') {
    $err = $err . "Введіть правильне значення для купюр по 20 грн<br>";
}
if (filter_var($banknote10, FILTER_VALIDATE_INT) == false && $banknote10 !='0') {
    $err = $err . "Введіть правильне значення для купюр по 10 грн<br>";
}
if (filter_var($banknote5, FILTER_VALIDATE_INT) == false && $banknote5 !='0') {
    $err = $err . "Введіть правильне значення для купюр по 5 грн<br>";
}
if ($err !='') {
    echo $err;
    echo '<a href="index.php">Back</a>';
    die();
}

$data['500'] -= $banknote500;
$data['200'] -= $banknote200;
$data['100'] -= $banknote100;
$data['50'] -= $banknote50;
$data['20'] -= $banknote20;
$data['10'] -= $banknote10;
$data['5'] -= $banknote5;

$handle = fopen('data.json','wb');

$str = json_encode($data);
fwrite($handle, $str);
fclose($handle);

$valuta = 'грн.';
echo "<h3>З рахунку знято:<br>"
." $banknote500 банкнот номіналом 500$valuta, <br>"
." $banknote200 банкнот номіналом 200$valuta, <br>"
." $banknote100 банкнот номіналом 100$valuta, <br>"
." $banknote50 банкнот номіналом 50$valuta, <br>"
." $banknote20 банкнот номіналом 20$valuta, <br>"
." $banknote10 банкнот номіналом 10$valuta та <br>"
." $banknote5 банкнот номіналом 5$valuta"
."</h3>";

//echo $banknote5.' -5, ', $banknote10.' -10';
echo "<h3>Залишилось:</h3>";
include "table.php";
printTable($data);


//include //открыть файл, если нет - варнинг, скрипт дальше выполняется
//require //открыть файл, если нет - остановка выполнения
//require_once //открыть файл, если нет - остановка выполнения, первый раз выполнит

//додати перевірку на відємні значення
//перевірити чи можемо видати таку суму , не перевищую доступну суму

//в  cmd> git clone link

//ctrl+shift+k - зробити пуш файлыв в гит
?>

<br>
<a href="index.php">Назад</a>














