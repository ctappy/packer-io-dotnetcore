# Packer setup for .net core

## Notes

If you add in a ssh key, I believe, digital ocean will change all of the
`PasswordAuthentication yes` to `PasswordAuthentication no`. To enable sftp
ssh into the server edit the last `PasswordAuthentication no` to
`PasswordAuthentication yes` and the created sftp user account can log in

dotnet core is using a reverse proxy to port 80, phppgadmin is set up on port 81

PhpPgAdmin url will be located at `<IP.AD.DR.ESS>:81/phppgadmin/`

## Includes
- ubuntu 16.04
- dotnet core
- sftp
- postgres
- phppgadmin
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
