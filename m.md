# Make a membership service with slowcgi(8), httpd(8), curl(1), jq(1), and PayPal

## files

	members
		$member_id
			email
			pin: $pin $remote_addr
			expires_at
			sessions
				$key: $remote_addr
		payments
			$member_id: $date_time $psp $amount $currency $days
	paypal
		secrets: $client_id $secret
		plans
			$plan_name
				id
				$timestamp.json
		argeements
			$member_id
				created
					$timestamp.json
				active
					id: $agreement_id
					$timestamp.json: $transactions
				canceled
					$id: $agreement_id
					$timestamp.json: $transactions

## cron

	reduce_transactions > expires_at
	dispatch mail_queue
	archive_restore_verify
	verify_setup (deps, psps)

## emails

	to members
		register
		approve_agreement
		cancel_agreement
		payment
	to the seller
		create_plan
		approve_agreement
		cancel_agreement
		payment
		archive_restore
