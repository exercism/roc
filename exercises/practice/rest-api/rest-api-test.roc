# These tests are auto-generated with test data from:
# https://github.com/exercism/problem-specifications/tree/main/exercises/rest-api/canonical-data.json
# File last updated on 2026-07-09

import RestApi exposing [get, post]

##
## user management
##

# no users
expect {
	database = {
		users: [],
	}
	result_json = database->get(
		{
			url: "/users",
			payload: "",
		},
	)?
	expected_json = "{\"users\": []}"
	result_json->is_equivalent_to(expected_json)?
}

# add user
expect {
	database = {
		users: [],
	}
	result_json = database->post(
		{
			url: "/add",
			payload: "{\"user\": \"Adam\"}",
		},
	)?
	expected_json = "{\"balance\": 0.0, \"name\": \"Adam\", \"owed_by\": {}, \"owes\": {}}"
	result_json->is_equivalent_to(expected_json)?
}

# get single user
expect {
	database = {
		users: [
			{
				name: "Adam",
				owes: Dict.from_list([]),
				owed_by: Dict.from_list([]),
				balance: 0.0,
			},
			{
				name: "Bob",
				owes: Dict.from_list([]),
				owed_by: Dict.from_list([]),
				balance: 0.0,
			},
		],
	}
	result_json = database->get(
		{
			url: "/users",
			payload: "{\"users\": [\"Bob\"]}",
		},
	)?
	expected_json = "{\"users\": [{\"balance\": 0.0, \"name\": \"Bob\", \"owed_by\": {}, \"owes\": {}}]}"
	result_json->is_equivalent_to(expected_json)?
}

##
## iou
##

# both users have 0 balance
expect {
	database = {
		users: [
			{
				name: "Adam",
				owes: Dict.from_list([]),
				owed_by: Dict.from_list([]),
				balance: 0.0,
			},
			{
				name: "Bob",
				owes: Dict.from_list([]),
				owed_by: Dict.from_list([]),
				balance: 0.0,
			},
		],
	}
	result_json = database->post(
		{
			url: "/iou",
			payload: "{\"amount\": 3.0, \"borrower\": \"Bob\", \"lender\": \"Adam\"}",
		},
	)?
	expected_json = "{\"users\": [{\"balance\": 3.0, \"name\": \"Adam\", \"owed_by\": {\"Bob\": 3.0}, \"owes\": {}}, {\"balance\": -3.0, \"name\": \"Bob\", \"owed_by\": {}, \"owes\": {\"Adam\": 3.0}}]}"
	result_json->is_equivalent_to(expected_json)?
}

# TODO: Uncomment the following test when https://github.com/roc-lang/roc/issues/10049 is resolved
## borrower has negative balance
# expect {
# 	database = {
# 		users: [
# 			{
# 				name: "Adam",
# 				owes: Dict.from_list([]),
# 				owed_by: Dict.from_list([]),
# 				balance: 0.0,
# 			},
# 			{
# 				name: "Bob",
# 				owes: Dict.from_list(
# 					[
# 						("Chuck", 3.0),
# 					],
# 				),
# 				owed_by: Dict.from_list([]),
# 				balance: -3.0,
# 			},
# 			{
# 				name: "Chuck",
# 				owes: Dict.from_list([]),
# 				owed_by: Dict.from_list(
# 					[
# 						("Bob", 3.0),
# 					],
# 				),
# 				balance: 3.0,
# 			},
# 		],
# 	}
# 	result_json = database->post(
# 		{
# 			url: "/iou",
# 			payload: "{\"amount\": 3.0, \"borrower\": \"Bob\", \"lender\": \"Adam\"}",
# 		},
# 	)?
# 	expected_json = "{\"users\": [{\"balance\": 3.0, \"name\": \"Adam\", \"owed_by\": {\"Bob\": 3.0}, \"owes\": {}}, {\"balance\": -6.0, \"name\": \"Bob\", \"owed_by\": {}, \"owes\": {\"Adam\": 3.0, \"Chuck\": 3.0}}]}"
# 	result_json->is_equivalent_to(expected_json)?
# }

# lender has negative balance
expect {
	database = {
		users: [
			{
				name: "Adam",
				owes: Dict.from_list([]),
				owed_by: Dict.from_list([]),
				balance: 0.0,
			},
			{
				name: "Bob",
				owes: Dict.from_list(
					[
						("Chuck", 3.0),
					],
				),
				owed_by: Dict.from_list([]),
				balance: -3.0,
			},
			{
				name: "Chuck",
				owes: Dict.from_list([]),
				owed_by: Dict.from_list(
					[
						("Bob", 3.0),
					],
				),
				balance: 3.0,
			},
		],
	}
	result_json = database->post(
		{
			url: "/iou",
			payload: "{\"amount\": 3.0, \"borrower\": \"Adam\", \"lender\": \"Bob\"}",
		},
	)?
	expected_json = "{\"users\": [{\"balance\": -3.0, \"name\": \"Adam\", \"owed_by\": {}, \"owes\": {\"Bob\": 3.0}}, {\"balance\": 0.0, \"name\": \"Bob\", \"owed_by\": {\"Adam\": 3.0}, \"owes\": {\"Chuck\": 3.0}}]}"
	result_json->is_equivalent_to(expected_json)?
}

# lender owes borrower
expect {
	database = {
		users: [
			{
				name: "Adam",
				owes: Dict.from_list(
					[
						("Bob", 3.0),
					],
				),
				owed_by: Dict.from_list([]),
				balance: -3.0,
			},
			{
				name: "Bob",
				owes: Dict.from_list([]),
				owed_by: Dict.from_list(
					[
						("Adam", 3.0),
					],
				),
				balance: 3.0,
			},
		],
	}
	result_json = database->post(
		{
			url: "/iou",
			payload: "{\"amount\": 2.0, \"borrower\": \"Bob\", \"lender\": \"Adam\"}",
		},
	)?
	expected_json = "{\"users\": [{\"balance\": -1.0, \"name\": \"Adam\", \"owed_by\": {}, \"owes\": {\"Bob\": 1.0}}, {\"balance\": 1.0, \"name\": \"Bob\", \"owed_by\": {\"Adam\": 1.0}, \"owes\": {}}]}"
	result_json->is_equivalent_to(expected_json)?
}

# lender owes borrower less than new loan
expect {
	database = {
		users: [
			{
				name: "Adam",
				owes: Dict.from_list(
					[
						("Bob", 3.0),
					],
				),
				owed_by: Dict.from_list([]),
				balance: -3.0,
			},
			{
				name: "Bob",
				owes: Dict.from_list([]),
				owed_by: Dict.from_list(
					[
						("Adam", 3.0),
					],
				),
				balance: 3.0,
			},
		],
	}
	result_json = database->post(
		{
			url: "/iou",
			payload: "{\"amount\": 4.0, \"borrower\": \"Bob\", \"lender\": \"Adam\"}",
		},
	)?
	expected_json = "{\"users\": [{\"balance\": 1.0, \"name\": \"Adam\", \"owed_by\": {\"Bob\": 1.0}, \"owes\": {}}, {\"balance\": -1.0, \"name\": \"Bob\", \"owed_by\": {}, \"owes\": {\"Adam\": 1.0}}]}"
	result_json->is_equivalent_to(expected_json)?
}

# lender owes borrower same as new loan
expect {
	database = {
		users: [
			{
				name: "Adam",
				owes: Dict.from_list(
					[
						("Bob", 3.0),
					],
				),
				owed_by: Dict.from_list([]),
				balance: -3.0,
			},
			{
				name: "Bob",
				owes: Dict.from_list([]),
				owed_by: Dict.from_list(
					[
						("Adam", 3.0),
					],
				),
				balance: 3.0,
			},
		],
	}
	result_json = database->post(
		{
			url: "/iou",
			payload: "{\"amount\": 3.0, \"borrower\": \"Bob\", \"lender\": \"Adam\"}",
		},
	)?
	expected_json = "{\"users\": [{\"balance\": 0.0, \"name\": \"Adam\", \"owed_by\": {}, \"owes\": {}}, {\"balance\": 0.0, \"name\": \"Bob\", \"owed_by\": {}, \"owes\": {}}]}"
	result_json->is_equivalent_to(expected_json)?
}

is_equivalent_to = |result_json, expected_json| {
	if expected_json.contains("\"users\"") {
		expected : RestApi.Database
		expected = Json.parse(expected_json)?
		result : RestApi.Database
		result = Json.parse(result_json)?
		Ok(result == expected)
	} else {
		expected : RestApi.User
		expected = Json.parse(expected_json)?
		result : RestApi.User
		result = Json.parse(result_json)?
		Ok(result == expected)
	}
}

# This program is only used to run tests with `roc test`, so main! does nothing.
main! = |_args| {
	Ok({})
}
