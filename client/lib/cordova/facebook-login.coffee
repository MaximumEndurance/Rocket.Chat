Meteor.loginWithFacebookCordova = (options, callback) ->
	if not callback and typeof options is "function"
		callback = options
		options = null

	credentialRequestCompleteCallback = Accounts.oauth.credentialRequestCompleteHandler(callback)

	fbLoginSuccess = (data) ->
		data.cordova = true

		Accounts.callLoginMethod
			methodArguments: [data]
			userCallback: callback

	if typeof facebookConnectPlugin isnt "undefined"
		facebookConnectPlugin.getLoginStatus (response) ->
			if response.status isnt "connected"
				facebookConnectPlugin.login ["public_profile", "email"], fbLoginSuccess, (error) ->
					console.log("" + error)
			else
				fbLoginSuccess(response)

		, (error) ->
			console.log("" + error)

	else
		Facebook.requestCredential(options, credentialRequestCompleteCallback)