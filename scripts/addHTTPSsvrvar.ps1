function Allow-ServerVariableForRewrite ([string] $serverVariable ) {
	[string] $applicationConfigFile = "c:\windows\system32\inetsrv\config\applicationHost.config"
	[xml]$applicationConfig = Get-Content $applicationConfigFile

 	$webServerElement = $applicationConfig.SelectSingleNode("//system.webServer")
 	if ($webServerElement -eq $null) {
   		throw "Cannot find system.webServer node in $applicationConfigFile"
 	}

    #find rewrite element
 	$rewriteElement = $webServerElement.SelectSingleNode("rewrite")

 	#if rewrite element is not found, add it
 	if ($rewriteElement -eq $null){
 		$rewriteElement = $applicationConfig.CreateElement("rewrite")
 		$webServerElement.AppendChild($rewriteElement)
 	}

	#find allowedServerVariables element
 	$allowedServerVariablesElement = $rewriteElement.SelectSingleNode("allowedServerVariables")

 	#if allowedServerVariables element is not found, add it
 	if ($allowedServerVariablesElement -eq $null){
 		$allowedServerVariablesElement = $applicationConfig.CreateElement("allowedServerVariables")
 		$rewriteElement.AppendChild($allowedServerVariablesElement)
 	}

 	$addName = $allowedServerVariablesElement.SelectSingleNode("add[@name='$serverVariable']")
 	if ($addName -ne $null) {
   		throw "Add with name $serverVariable exists"
 	}

 	# Create new element for <add name>
 	$addhttps = $applicationConfig.CreateElement("add")

 	# Create attribute "Name", and set its value
 	$settingsAttribute = $applicationConfig.CreateAttribute("name")
 	$settingsAttribute.Value = "$serverVariable"

 	# Add attribute to <addhttps>
 	$addhttps.Attributes.Append($settingsAttribute)

 	$allowedServerVariablesElement.AppendChild($addHttps)
 	$applicationConfig.Save($applicationConfigFile)
}

Allow-ServerVariableForRewrite "HTTPS"