<head>
<title>Nachricht gesendet</title>
</head>

<body>
<?PHP

if ($_POST[nachricht]) {
   mail("karamatsch@hotmail.de","Nachricht von $_POST[name]",$_POST[nachricht]);    
   echo "Danke für ihre Nachricht, wir werden sie schnelst möglich bearbeiten!<br>";



} else {
   echo "Fehler beim Übermitteln der Nachricht. Wenden sie sich bitte per Email an karamasch@hotmail.de<br>";
   
}

?>

</body>
</html>
