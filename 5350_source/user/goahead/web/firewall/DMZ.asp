<html>
<head>
<title>MAC Filtering Settings</title>
<link rel="stylesheet" href="/style/normal_ws.css" type="text/css">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="-1">
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<script type="text/javascript" src="/lang/b28n.js"></script>
<script language="JavaScript" type="text/javascript">
Butterlate.setTextDomain("firewall");
function deleteClick()
{
    return true;
}


function checkRange(str, num, min, max)
{
	d = atoi(str,num);
	if(d > max || d < min)
		return false;
	return true;
}


function atoi(str, num)
{
	i=1;
	if(num != 1 ){
		while (i != num && str.length != 0){
			if(str.charAt(0) == '.'){
				i++;
			}
			str = str.substring(1);
		}
	  	if(i != num )
			return -1;
	}
	
	for(i=0; i<str.length; i++){
		if(str.charAt(i) == '.'){
			str = str.substring(0, i);
			break;
		}
	}
	if(str.length == 0)
		return -1;
	return parseInt(str, 10);
}


function isAllNum(str)
{
	for (var i=0; i<str.length; i++){
	    if((str.charAt(i) >= '0' && str.charAt(i) <= '9') || (str.charAt(i) == '.' ))
			continue;
		return 0;
	}
	return 1;
}

function checkIPAddr(field)
{
    if(field.value == ""){
        if(langtype=="zhcn")
    	  alert("出错：IP地址不能为空");
    	  else
        alert("Error. IP address is empty.");
        field.value = field.defaultValue;
        field.focus();
        return false;
    }

    if ( isAllNum(field.value) == 0) {
        if(langtype=="zhcn")
    	  alert("必须为[0-9]之间的数字");
    	  else
        alert('It should be a [0-9] number.');
        field.value = field.defaultValue;
        field.focus();
        return false;
    }

    if( (!checkRange(field.value,1,0,255)) ||
        (!checkRange(field.value,2,0,255)) ||
        (!checkRange(field.value,3,0,255)) ||
        (!checkRange(field.value,4,1,254)) ){
        if(langtype=="zhcn")
    	  alert("IP格式错误");
    	  else
        alert('IP format error.');
        field.value = field.defaultValue;
        field.focus();
        return false;
    }

   return true;
}


function formCheck()
{
	if(!document.DMZ.DMZEnabled.options.selectedIndex){
		// user choose disable
		return true;
	}

	if(document.DMZ.DMZIPAddress.value == ""){
		if(langtype=="zhcn")
    	  alert("出错：没有设置IP地址");
    	  else
		alert("Not set a ip address.");
		document.DMZ.DMZIPAddress.focus();
		return false;
	}

	if(! checkIPAddr(document.DMZ.DMZIPAddress) ){
		if(langtype=="zhcn")
    	  alert("IP地址格式错误");
    	  else
		alert("IP address format error.");
		document.DMZ.DMZIPAddress.focus();
		return false;
	}

	return true;
}


function display_on()
{
  if(window.XMLHttpRequest){ // Mozilla, Firefox, Safari,...
    return "table-row";
  } else if(window.ActiveXObject){ // IE
    return "block";
  }
}

function disableTextField (field)
{
  if(document.all || document.getElementById)
    field.disabled = true;
  else {
    field.oldOnFocus = field.onfocus;
    field.onfocus = skip;
  }
}

function enableTextField (field)
{
  if(document.all || document.getElementById)
    field.disabled = false;
  else {
    field.onfocus = field.oldOnFocus;
  }
}

function initTranslation()
{
	var e = document.getElementById("dmzTitle");
	e.innerHTML = _("dmz title");
	e = document.getElementById("dmzIntroduction");
	e.innerHTML = _("dmz introduction");

	e = document.getElementById("dmzSetting");
	e.innerHTML = _("dmz setting");
	e = document.getElementById("dmzSet");
	e.innerHTML = _("dmz setting");
	e = document.getElementById("dmzDisable");
	e.innerHTML = _("firewall disable");
	e = document.getElementById("dmzEnable");
	e.innerHTML = _("firewall enable");
	e = document.getElementById("dmzIPAddr");
	e.innerHTML = _("dmz ipaddr");
	e = document.getElementById("dmzApply");
	e.value = _("firewall apply");
	e = document.getElementById("dmzReset");
	e.value = _("firewall reset");
}

function updateState()
{
	initTranslation();
	if(document.DMZ.DMZEnabled.options.selectedIndex == 1){
		enableTextField(document.DMZ.DMZIPAddress);
	}else{
		disableTextField(document.DMZ.DMZIPAddress);
	}
}

</script>
</head>


<!--     body      -->
<body onload="updateState()">
<table class="body"><tr><td>
<h1 id="dmzTitle"> DMZ Settings </h1>
<% checkIfUnderBridgeModeASP(); %>
<p id="dmzIntroduction"> You may setup a De-militarized Zone(DMZ) to separate internal network and Internet.</p>

<form method=post name="DMZ" action=/goform/DMZ>
<table width="400" border="0" cellpadding="2" cellspacing="1">
<tr>
  <td colspan="2" id="dmzSetting"  class="title">DMZ Settings</td>
</tr>
<tr>
	<td id="dmzSet" class="head">
		DMZ Settings
	</td>
	<td class="content">
	<select onChange="updateState()" name="DMZEnabled" size="1">
	<option value=0 <% getDMZEnableASP(0); %> id="dmzDisable">Disable</option>
    <option value=1 <% getDMZEnableASP(1); %> id="dmzEnable">Enable</option>
    </select>
    </td>
</tr>

<tr>
	<td id="dmzIPAddr"  class="head">
		DMZ IP Address
	</td>
	<td  class="content">
  		<input type="text" size="24" name="DMZIPAddress" value=<% showDMZIPAddressASP(); %> >
	</td>
</tr>

<tr>
	<td colspan=2  class="content">
		<input type="submit" value="Apply" id="dmzApply" name="addDMZ" onClick="return formCheck()"> &nbsp;&nbsp;
		<input type="reset" value="Reset" id="dmzReset" name="reset">
	</td>
</tr>
</table>
	
</form>
</td></tr></table>
</body>
</html>
