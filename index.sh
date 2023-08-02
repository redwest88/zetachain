#!/bin/bash

API_URL="https://rpc.ankr.com/http/zetachain_athens_testnet/cosmos"
validators_response=$(curl -s "$API_URL"/staking/v1beta1/validators | tr -d '\n')

PS3='Enter your option: '
options=("Show network status" "Show validators list" "Show proposals list" "Quit")
selected="You choose the option"

select opt in "${options[@]}"
do
    case $opt in
        "${options[0]}")
            echo "$selected $opt"
            sleep 1
				# run func
            break
            ;;
        "${options[1]}")
            echo "$selected $opt"
            sleep 1
				show_network_status
            break
            ;;
			"${options[1]}")
            echo "$selected $opt"
            sleep 1
				3333
            break
            ;;
        "${options[3]}")
			echo "$selected $opt"
            break
            ;;
        *) echo "unknown option $REPLY";;
    esac
done

function show_network_status() {

}

function show_validators_list() {
	validators_response=$(curl -s "$API_URL"/staking/v1beta1/validators | tr -d '\n')

	if [ -z "$validators_response" ]; then
		echo "Failed to fetch data from the API. Please check your connection or the API endpoint."
		exit 1
	fi

	validators_info=$(echo "$validators_response" | jq --raw-output '.validators | map({name: .description.moniker, operator_address: .operator_address, status: .status, voting_power: .tokens})')

	if [ -z "$validators_info" ]; then
		echo "No validators found in the response."
		exit 1
	fi

	echo "Zetachain Validators Information:"
	echo "================================="
	echo
	echo "$validators_info" | jq -c '.[]' | while read -r object; do
		name=$(echo "$object" | jq -r '.name')
		operator_address=$(echo "$object" | jq -r '.operator_address')
		status=$(echo "$object" | jq -r '.status')
		voting_power=$(bc <<< "scale=6; $(echo "$object" | jq -r '.voting_power') / 1000000000000000000")
		echo "Name: $name"
		echo "Operator Address: $operator_address"
		echo "Status: $status"
		echo "Voting Power: $voting_power ZETA"
		echo "----------------------"
	done
	echo
	echo "================================="
}

function show_proposals_list() {

}
