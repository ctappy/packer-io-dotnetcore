# Packer setup for .net core

## Includes
- ubuntu 16.04
- dotnet core
- sftp
- postgres
- mypgadmin
- apache reverse proxy


## Setup
Create the file secrets.json with the following content, and update the api token veriable
```
{
    "variables": {
        "secret_api_token":"123456789"
    }
}

```

## Run

```
packer-io ./do-asp-netcore-pg-admin-sftp.json
```