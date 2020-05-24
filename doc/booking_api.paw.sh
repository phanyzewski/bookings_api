## Accounts List
curl "http://localhost:3000/accounts"

## Account Create
curl -X "POST" "http://localhost:3000/accounts"

## Accounts Search
curl "http://localhost:3000/accounts/search?email_address=paul%40example.com&first_name=paul&last_name=h&phone_number&vin"

## Account Destroy
curl -X "DELETE" "http://localhost:3000/accounts/5325ecff-1506-4a40-8138-cd5f838eed49"

## Bookings List
curl "http://localhost:3000/bookings"

## Bookings Create
curl -X "POST" "http://localhost:3000/bookings" \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "work_order": "'"'"'{\\"job_id\\":\\"1\\",\\"duration\\":\\"2\\",\\"work\\":[{\\"diag\\":\\"1\\",\\"oil change\\":\\"0.5\\",\\"rotation\\":\\"0.5\\"}]}'"'"'",
  "vehicle_id": "829362d8-5ac7-4d4f-b832-1086b3576139",
  "start_time": "\\"2020-05-28 12:00:00 UTC\\"",
  "account_id": "1342ae0d-2aeb-4537-a9ab-fbf43235c6d1",
  "duration": "9000"
}'

## Bookings Update
curl -X "PATCH" "http://localhost:3000/bookings/e4cde76c-2666-4765-8867-45bc62097eef" \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "start_time": "2020-05-25T18:00:00.000Z",
  "work_order": "'"'"'{\\"job_id\\":\\"1\\",\\"duration\\":\\"2\\",\\"work\\":[{\\"diag\\":\\"1\\",\\"oil change\\":\\"0.5\\",\\"rotation\\":\\"0.5\\"}]}'"'"'"
}'

## Bookings Destroy
curl -X "DELETE" "http://localhost:3000/bookings/f418137c-e827-4b78-888c-30cb4e7696b4"

## Identity Create with account_id
curl -X "POST" "http://localhost:3000/identities" \
     -H 'Content-Type: application/json' \
     -d $'{
  "account_id": "665b135f-e273-49ce-abe9-0b142c5622ff",
  "first_name": "existing",
  "last_name": "account"
}'

## Identitiy create without account_id
curl -X "POST" "http://localhost:3000/identities" \
     -H 'Content-Type: application/json' \
     -d $'{
  "first_name": "paul",
  "last_name": "h"
}'

## Identity create with email, telepohne
curl -X "POST" "http://localhost:3000/identities" \
     -H 'Content-Type: application/json' \
     -d $'{
  "email_address": {
    "email": "paul@example.com",
    "preferred": "false"
  },
  "last_name": "h",
  "telephone": {
    "preferred": "true",
    "phone_number": "+1(123)555-5555",
    "allow_sms": "true",
    "phone_type": "mobile"
  },
  "first_name": "paul"
}'

## Identity Update
curl -X "PATCH" "http://localhost:3000/identities/3594f042-4ae1-4843-842e-4fb912cbe7b7" \
     -H 'Content-Type: application/json' \
     -d $'{
  "email_address": {
    "email": "paul-new-email@example.com",
    "preferred": "false"
  },
  "last_name": "new email",
  "telephone": {
    "preferred": "true",
    "phone_number": "1235555555",
    "allow_sms": "true",
    "type": "mobile"
  },
  "account_id": "1342ae0d-2aeb-4537-a9ab-fbf43235c6d1",
  "first_name": "bob new email"
}'

## Identity Destroy
curl -X "DELETE" "http://localhost:3000/identities/31e94b23-af1d-4c25-acac-d8365767b1bb"

## Vehicles List
curl "http://localhost:3000/vehicles"

## Vehicle Create Simple
curl -X "POST" "http://localhost:3000/vehicles" \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "vin": "1234",
  "year": "1996",
  "account_id": "665b135f-e273-49ce-abe9-0b142c5622ff"
}'

## Vehicle Create Full
curl -X "POST" "http://localhost:3000/vehicles" \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "color": "Black",
  "model": "M3",
  "vin": "1234",
  "year": "1996",
  "account_id": "1342ae0d-2aeb-4537-a9ab-fbf43235c6d1",
  "make": "BMW"
}'

## Vehicle Update
curl -X "PATCH" "http://localhost:3000/vehicles/829362d8-5ac7-4d4f-b832-1086b3576139" \
     -H 'Content-Type: application/json; charset=utf-8' \
     -d $'{
  "color": "Sky Blue",
  "model": "M3",
  "vin": "1234",
  "year": "1996",
  "account_id": "1342ae0d-2aeb-4537-a9ab-fbf43235c6d1",
  "make": "BMW"
}'

## Vehicle Destroy
curl -X "DELETE" "http://localhost:3000/vehicles/0cfa0b22-661b-49a8-abc0-bc3d598eb286"
