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
  "secret_api_token":"123456789abc",
  "sftp_username": "sftp_user",
  "sftp_password": "change_me_123",
  "sftp_user_root_login_dir": "/",
  "db_name": "aspnetcore",
  "db_username": "aspnetcore",
  "db_password": "change_me_123",
  "dotnet_install_package": "dotnet-dev-2.0.0"
}
```

## Run

```
packer-io build -var-file=secrets.json do-asp-netcore-pg-admin-sftp.json
```
