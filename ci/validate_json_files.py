import os
import sys
import json 

json_test_failed_files = []

def test_json_files():
    for path, subdirs, files in os.walk(os.getcwd()):
        for name in files: 
            file = os.path.join(path, name)
            if file.endswith(".json"):
                print('Validating file: %s') % file
                with open(file) as json_file:
                    try:
                        json.load(json_file)
                    except ValueError as error:
                        print('Invalid JSON: %s') % error
                        json_test_failed_files.append(file)

    if len(json_test_failed_files) > 0:
        print('Test failed. Invalid JSON found.')
        print(json_test_failed_files)
        sys.exit(1)

    else: 
        print('Test passed. No JSON errors found.')
        sys.exit(0)

test_json_files()