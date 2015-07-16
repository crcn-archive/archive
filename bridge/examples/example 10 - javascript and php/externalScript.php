
<Holder>
<?php

$user = @$_GET["user"];
$pass = @$_GET["pass"]; 
$secretNum = @$_GET["secretNum"];  


if($user == "user" && $pass == "pass")
{
	 
?>    
	<run script="{#js:alert('thanks for logging in!');}" /> 
	<?php for($i = 0; $i < $secretNum; $i++){?>
	<Container instance:id="secretBox" style="backgroundColors:#009900;" alpha="0" percentX="{Math.random()*100}" percentY="{Math.random()*100}">   
		<Label text="secret box" />
	</Container>                   
	
	<Tween target="{secretBox}" property="alpha" start="0" stop="1" duration="1000" /> 
	<sleep time="50" />
   
<?php 
}
}
else
{  
 ?>
<run script="{#js:alert('fail');}" /> 
<?php    
}   
?>
</Holder>