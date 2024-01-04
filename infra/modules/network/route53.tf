# ホストゾーンを作成
resource "aws_route53_zone" "this" {
  name = var.domain_name
}

/* 
    api.{domain_name}のAレコードを作成
    AレコードにALBのDNS名を設定(backend)
*/
# resource "aws_route53_record" "this_1" {
#   zone_id = aws_route53_zone.this.zone_id
#   name    = "api.${var.domain_name}"
#   type    = "A"

#   alias {
#     name                   = "zenn-test-alb-backend-1383991895.ap-northeast-1.elb.amazonaws.com"
#     zone_id                = "Z14GRHDCWA56QT"
#     evaluate_target_health = true
#   }
# }

/* 
    {domain_name}のAレコードを作成
    AレコードにALBのDNS名を設定(frontend)
*/
# resource "aws_route53_record" "this_2" {
#   zone_id = aws_route53_zone.this.zone_id
#   name    = var.domain_name
#   type    = "A"

#   alias {
#     name                   = "zenn-test-alb-fronend-1518751022.ap-northeast-1.elb.amazonaws.com"
#     zone_id                = "Z14GRHDCWA56QT"
#     evaluate_target_health = true
#   }
# }
