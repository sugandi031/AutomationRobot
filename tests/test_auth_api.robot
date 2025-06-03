*** Settings ***
Library           RequestsLibrary
Library           JSONSchemaLibrary
Library           ../helpers/yaml_helper.py
Library           ../helpers/path_helper.py

Suite Setup    Setup Paths


*** Variables ***
${YAML_PATH}       NONE
${SCHEMA_PATH}=    auth_schema.json
${ENDPOINT_PATH}   NONE


*** Keywords ***
Setup Paths
    ${YAML_PATH}=       Get Absolute Path    yaml/auth_headers_body.yaml
    ${ENDPOINT_PATH}=   Get Absolute Path    yaml/endpoint.yaml
    Set Suite Variable    ${YAML_PATH}
    Set Suite Variable    ${SCHEMA_PATH}
    Set Suite Variable    ${ENDPOINT_PATH}
    Log    YAML Path: ${YAML_PATH}
    Log    SCHEMA Path: ${SCHEMA_PATH}
    Log    ENDPOINT Path: ${ENDPOINT_PATH}

*** Test Cases ***
Update Headers And Body Then Test Auth
    # Update headers and body via parameters
    Update Header    ${YAML_PATH}    Authorization    Bearer MY-NEW-TOKEN
    Update Body      ${YAML_PATH}    apiKey           RL8Kx6QcrndDGF6O9nXLSjMYNG4GGdokj47xueVXbIa

    # Load YAML content
    ${data}=         Load YAML    ${YAML_PATH}
    ${endpoint}=     Load YAML    ${ENDPOINT_PATH}
    ${headers}=      Set Variable    ${data['headers']}
    ${body}=         Set Variable    ${data['body']}
    ${path}=         Set Variable    ${endpoint['auth_path']}
    ${url}=         Set Variable    ${endpoint['base_url']}

    Create Session    api_session    ${url}
    # Send request
    ${response}=     POST On Session    api_session    ${path}    json=${body}    headers=${headers}
    Should Be Equal As Integers    ${response.status_code}    200

    ${parsed}=      Evaluate    json.loads("""${response.content}""")    json
    Validate Json    ${SCHEMA_PATH}    ${parsed}


