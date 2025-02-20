locals {
  users = {
    for user in csvdecode(file(var.csv_file)) :
    user.email => {
      email            = user.email
      password         = lower("${replace(user.name, " ", "")}${substr(user.email, 0, 3)}!2025")
      name             = user.name
      transformed_name = upper("${substr(split(" ", user.name)[0], 0, 1)}${split(" ", user.name)[1]}") # Pass = removes space from name, add first 3 letters from email, appens !2025
    }
  }
}