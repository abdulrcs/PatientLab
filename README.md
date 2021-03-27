
# Readme
First of all make sure you have Docker desktop and Visual Studio Code

1. Open Visual Studio Code

2. In the terminal clone this repository with

   ```bash
   git clone https://github.com/okanemo/Abdul-Rahman.git
   ```

3. Install the [Remote Container](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension in Visual Studio Code to run the docker container

4. CTRL+SHIFT+P select Rebuild and Reopen in Container
![Rebuild and Reopen in Container](https://i.imgur.com/U1axqov.png)

   After the dev container fully loaded, you can open up the terminal and run the following command

   ```bash
   bundle install # Install the dependencies
   ```

   ```bash
   rake db:create db:migrate # Create the database and migrate it
   ```

   ```bash
   rails s # Start the app
   ```

6. The app is started! :tada:

# Usage

To test the API handler, we need a way to mock the external API and handle it, we can use cURL.

Open up another terminal and curl a POST into http://localhost:3000/patient_lab

### Case 1

```bash
curl -i -H "Content-Type:application/json" -d '{"date_of_test":"20210227134300","id_number":"IC000A2","patient_name":"Patient A4","gender":"F","date_of_birth":"19940231","lab_number":"QT196-21-124","clinic_code":"QT196","lab_studies":[{"code":"2085-9","name":"HDL Cholesterol","value":"cancel","unit":"mg/dL","ref_range":"> 59","finding":"A","result_state":"F"}]}' http://localhost:3000/patient_lab
```

### Response

Because the `date_of_birth` the API handler knows that it's invalid (There's no such thing as 31 February) And return a 422 Unprocessable Entity

```bash
HTTP/1.1 422 Unprocessable Entity
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Referrer-Policy: strict-origin-when-cross-origin
Content-Type: application/json; charset=utf-8
Vary: Accept
Cache-Control: no-cache
X-Request-Id: d2e1eb38-ce74-4cd9-9483-4e276f8bd38e
X-Runtime: 0.248350
Transfer-Encoding: chunked
```

### Case 2

```bash
curl -i -H "Content-Type:application/json" -d '{"patient_data":{"id_number":"IC000A3","first_name":"Patient","last_name":"A5","phone_mobile":"+6500000000","gender":"M","date_of_birth":"19940228"},"date_of_test":"20210227134300","lab_number":"QT196-21-124","clinic_code":"QT196","lab_studies":[{"code":"2085-9","name":"HDL Cholesterol","value":"cancel","unit":"mg/dL","ref_range":"> 59","finding":"A","result_state":"F"}]}' http://localhost:3000/patient_lab
```

### Response

The parameters are valid, so it returns 201 and the JSON data itself.

```bash
HTTP/1.1 201 Created
X-Frame-Options: SAMEORIGIN
X-XSS-Protection: 1; mode=block
X-Content-Type-Options: nosniff
X-Download-Options: noopen
X-Permitted-Cross-Domain-Policies: none
Referrer-Policy: strict-origin-when-cross-origin
Content-Type: application/json; charset=utf-8
Vary: Accept
ETag: W/"a2193fb6709baa0ebaa6043633e6478f"
Cache-Control: max-age=0, private, must-revalidate
X-Request-Id: b50b0d68-c64b-439e-9c18-1bf226dafe43
X-Runtime: 0.095228
Transfer-Encoding: chunked

{"id":1,"date_of_test":"2021-02-27T13:43:00.000Z","id_number":"IC000A3","patient_name":"Patient A5","gender":"M","date_of_birth":"1994-02-28","phone_mobile":"+6500000000","lab_number":"QT196-21-124","clinic_code":"QT196","code":"2085-9","name":"HDL Cholesterol","value":"cancel","unit":"mg/dL","ref_range":"\u003e 59","finding":"A","result_state":"F","created_at":"2021-03-27T00:40:30.403Z","updated_at":"2021-03-27T00:40:30.403Z"}
```

## Querying the Database

To look up all patient data in the database, we can send a GET request to http://localhost:3000/patient_lab

```bash
curl http://localhost:3000/patient_lab
```

### Response

It return the whole patient data in an array of objects.

```json
[{"id":1,"date_of_test":"2021-02-27T13:43:00.000Z","id_number":"IC000A3","patient_name":"Patient A5","gender":"M","date_of_birth":"1994-02-28","phone_mobile":"+6500000000","lab_number":"QT196-21-124","clinic_code":"QT196","code":"2085-9","name":"HDL Cholesterol","value":"cancel","unit":"mg/dL","ref_range":"\u003e 59","finding":"A","result_state":"F","created_at":"2021-03-27T00:40:30.403Z","updated_at":"2021-03-27T00:40:30.403Z"}]
```

