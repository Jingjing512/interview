import json
import requests


def post_filtered_json(file_path, url):
    try:
        # Step 1: Read and validate the JSON file
        with open(file_path, 'r') as file:
            data = json.load(file)  # Parse the JSON file
            print(f'data : {data}')

    except json.JSONDecodeError as e:
        print(f"Invalid JSON in {file_path}: {e}")
        return
    except FileNotFoundError:
        print(f"File {file_path} not found.")
        return

    # Step 2: Filter the JSON to include only objects with 'private' set to False # noqa
    filtered_data = {key: value for key, value in data.items() if value.get('private') == False} # noqa

    # Step 3: Make the REST POST request to the web service
    try:
        response = requests.post(url, json=filtered_data)
        print(f'response is {response}')

        # Ensure the response is successful
        if response.status_code == 200:
            try:
                response_data = response.json()  # Parse the JSON response from the server # noqa    
                # Step 4: Print the key of every object that has a child attribute "valid" set to true # noqa
                for key, value in response_data.items():
                    if value.get('valid') == True: # noqa
                        print(f"Key with valid=True: {key}")
            except json.JSONDecodeError as e:
                print(f"Error parsing the JSON response: {e}")
        else:
            print(f"Error: Received status code {response.status_code} from the server.") # noqa
    except requests.exceptions.RequestException as e:
        print(f"Error making HTTP request: {e}")


# Main function to drive the script execution
def main():
    # Path to the example.json file and the URL of the web service endpoint
    file_path = 'example.json'  # You can replace this with the actual file path # noqa
    url = "https://example.com/service/generate"  # Replace with the actual URL    # noqa
    # Call the function with the file path and URL
    post_filtered_json(file_path, url)


# Call the main function when the script is executed
if __name__ == "__main__":
    main()
