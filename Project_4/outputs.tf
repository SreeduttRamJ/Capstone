output "iam_user_name" {

  value = aws_iam_user.iam_user.name

}



output "access_key_id" {

  value = aws_iam_access_key.user_keys.id

}



output "secret_access_key" {

  value = aws_iam_access_key.user_keys.secret

  sensitive = true

}
