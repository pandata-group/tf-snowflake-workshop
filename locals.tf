locals {
  users = {
    for user in csvdecode(data.aws_s3_object.csv_file.body) :
    user.email => {
      email            = user.email
      password         = lower("${replace(user.name, " ", "")}${substr(user.email, 0, 3)}!2025")
      name             = user.name
      transformed_name = upper("${substr(split(" ", user.name)[0], 0, 1)}${split(" ", user.name)[1]}")
    }
  }
}